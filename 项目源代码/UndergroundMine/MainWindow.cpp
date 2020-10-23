#include "MainWindow.h"

#include <QtWidgets/QDockWidget>
#include <QtWidgets/QToolBar>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QFileDialog>
#include <QFileInfo>
#include <QMessageBox>
#include <QString>
#include <QStringList>
#include <QSqlQuery>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

#include <osg/ShapeDrawable>
#include <osg/PositionAttitudeTransform>
#include <osgDB/ReadFile>
#include <osgDB/Registry>
#include <osgDB/ReaderWriter>

#include <cmath>
#include <vector>
#include <fstream>
#include <sstream>

#include <QDebug>

using namespace osg;
using namespace std;

MainWindow::MainWindow(QWidget *parent)
	: QMainWindow(parent)
{
	readConfig();
	initDatabase();
	osgWidget = new QtOSGWidget(this);
	pickHandler = new PickHandler();
	wanderHandler = new WanderHandler;
	wanderHandler->setStep(5);

	scene = initScene();
	osgWidget->getViewer()->addEventHandler(pickHandler);
	osgWidget->getViewer()->addEventHandler(wanderHandler);
	osgWidget->getViewer()->setSceneData(scene);


	modelEditWidget = new ModelEditWidget(this, &mineNetwork, scene.get(), osgWidget);

	this->setCentralWidget(osgWidget);
	createLayout();
	resize(1200, 1000);

	createToolbar();

	connect(osgWidget, SIGNAL(trackballRotated(osg::Quat)), modelEditWidget->getCoordinateWidget(), SLOT(rotateTrackball(osg::Quat)));
	connect(modelEditWidget->getCoordinateWidget(), SIGNAL(trackballRotated(osg::Quat)), osgWidget, SLOT(rotateTrackball(osg::Quat)));
	connect(pickHandler, SIGNAL(picked(std::string)), modelEditWidget, SLOT(picked(std::string)));
	connect(pickHandler, SIGNAL(picked(osg::Node*)), modelEditWidget, SLOT(addPickedNode(osg::Node*)));
	connect(pickHandler, SIGNAL(unPicked(osg::Node*)), modelEditWidget, SLOT(dropPickedNode(osg::Node*)));
	connect(pickHandler, SIGNAL(selectGroundPoint(osg::Vec3)), modelEditWidget, SLOT(selectGroundPoint(osg::Vec3)));
	connect(modelEditWidget, SIGNAL(saveSceneData()), this, SLOT(saveSceneData()));

	statusBar()->showMessage("就绪");
}

MainWindow::~MainWindow()
{
	//    delete osgWidget;
	//    delete toolbar;
}

void MainWindow::readConfig()
{
	QFile file(CONFIGFILE);
	if (file.open(QIODevice::ReadOnly)) {
		QByteArray json = file.readAll();
		QJsonObject obj = QJsonDocument::fromJson(QString(json).toUtf8()).object();
		db_host = obj["host"].toString();
		odbc_name = obj["odbc_name"].toString();
		db_user = obj["user"].toString();
		db_password = obj["password"].toString();
		scene_file = obj["scene_file"].toString();
		qDebug() << db_host << odbc_name << db_user << db_password;
	}
}

void MainWindow::initDatabase()
{
	db = QSqlDatabase::addDatabase("QMYSQL");
	db.setHostName(db_host);
	db.setUserName(db_user);
	db.setPort(3306);
	db.setDatabaseName(odbc_name);
	db.setPassword(db_password);
	if (db.open()) {
		qDebug() << "打开数据库连接";
	}
	else {
		qDebug() << "打开数据库失败";
	}
}

void MainWindow::createLayout()
{
	QDockWidget *dockWidget = new QDockWidget("工具箱", this);
	dockWidget->setAllowedAreas(Qt::LeftDockWidgetArea | Qt::RightDockWidgetArea | Qt::TopDockWidgetArea | Qt::BottomDockWidgetArea);
	modelEditWidget->setParent(dockWidget);
	modelEditWidget->setMaximumWidth(350);
	modelEditWidget->setMinimumWidth(350);
	dockWidget->setWidget(modelEditWidget);
	addDockWidget(Qt::RightDockWidgetArea, dockWidget);
	dockWidget->show();
}

Quat getQuat(Vec3d d)
{
	Vec3d m(0, 0, 1);
	d.normalize();
	Vec3d a = m ^ d;
	Quat q(a.x(), a.y(), a.z(), (m.length2() * d.length2()) + (m * d));

	return q;
}

ref_ptr<Group> MainWindow::loadMarkFromDB()
{
	ref_ptr<Group> group = new Group;

	QSqlQuery query;
	query.exec("SELECT ID, name, point FROM mark");
	while (query.next()) {
		string name = query.value(1).toString().toStdString();
		string point = query.value(2).toString().toStdString();
		stringstream ss(point);
		char c;
		double x, y, z;

		ref_ptr<Group> geode(new Group);
		geode->setName(name);

		ss >> c >> x >> c >> y >> c >> z;
		Vec3d v(x / 10, y / 10, z / 10 + 5);                // +5 是因为 mark.ive 自身高度
		osg::ref_ptr<osg::Node> mark = osgDB::readNodeFile("mark.ive");

		osg::ref_ptr<osg::PositionAttitudeTransform> pat = new osg::PositionAttitudeTransform();
		pat->setPosition(v);
		pat->setScale(osg::Vec3(0.065f, 0.065f, 0.065f));
		pat->addChild(mark.get());
		geode->addChild(pat.get());
		group->addChild(geode);
	}
	return group;
}

ref_ptr<Group> MainWindow::initScene()
{
	ref_ptr<Group> root = new Group;
	if (QFileInfo::exists(DATAFILE) && QFileInfo(DATAFILE).isFile()) {
		root->addChild(osgDB::readNodeFile(DATAFILE));
	}

	//添加标记
	root->addChild(loadMarkFromDB());

	return root;
}


void MainWindow::createToolbar()
{
	toolbar = addToolBar("工具栏");
	
}


void MainWindow::saveSceneData()
{
	ref_ptr<Group> root = dynamic_cast<Group*>(osgWidget->getViewer()->getSceneData());

	// 删除场景中的相机
	unsigned num = root->getNumChildren();
	std::vector<Camera*> cameras;

	for (unsigned i = 0; i < num; ++i) {
		ref_ptr<Camera> childAsHudCamera = dynamic_cast<Camera*>(root->getChild(i));
		if (childAsHudCamera) {
			cameras.push_back(childAsHudCamera);
		}
	}

	for (Camera *c : cameras) {
		root->removeChild(c);
	}

	//    optimizer.optimize(root);
	osgDB::Registry *reg = osgDB::Registry::instance();
	reg->writeNode(*root, DATAFILE, reg->getOptions());

	QMessageBox::about(this, "保存", "保存场景数据成功");
}
