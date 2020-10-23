#include "modeleditwidget.h"
#include "windowcapturecallback.h"
#include <QTextCodec>
#pragma execution_character_set("utf-8")  
#include <QtGlobal>
#include <QTime>
#include <QFormLayout>
#include <QVBoxLayout>
#include <QLabel>
#include <QRadioButton>
#include <QSlider>
#include <QPushButton>
#include <QString>
#include <QKeyEvent>
#include <QShortcut>
#include <QKeySequence>
#include <QMessageBox>
#include <QSqlQuery>
#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

#include <QTextStream>
#include <qfiledialog.h>

#include <osgFX/Scribe>
#include <osgDB/ReadFile>
#include <osg/PositionAttitudeTransform>
#include <osgUtil/PlaneIntersector>
#include <osgText/Text>

#include <string>

using namespace osg;
using namespace std;

ModelEditWidget::ModelEditWidget(QWidget *parent, Network3D *network, osg::Group *scene, QtOSGWidget *osgWidget) : QWidget(parent), mineNetwork(network), scene(scene), osgWidget(osgWidget)
{
	readConfig();
	coordinateWidget = new QtOSGWidget(this);
	ref_ptr<Group> root = new Group;
	root->addChild(osgDB::readNodeFile("axes.osgt"));
	coordinateWidget->getViewer()->setSceneData(root);
	crossSectionGeode = new Geode;
	rect_crossSectionGeode = new Geode;

	createFormGroupBox();
	QVBoxLayout *mainLayout = new QVBoxLayout;
	mainLayout->addWidget(editBox);
	mainLayout->addWidget(analysisBox);
	mainLayout->addWidget(rect_analysisBox);
	mainLayout->addWidget(coordinateBox);
	setLayout(mainLayout);

	new QShortcut(QKeySequence("A"), this, SLOT(translateXNegtive()), SLOT(translateXNegtive()));
	new QShortcut(QKeySequence("D"), this, SLOT(translateXPositive()), SLOT(translateXPositive()));
	new QShortcut(QKeySequence("S"), this, SLOT(translateYNegtive()), SLOT(translateYNegtive()));
	new QShortcut(QKeySequence("W"), this, SLOT(translateYPositive()), SLOT(translateYPositive()));
	new QShortcut(QKeySequence("Q"), this, SLOT(translateZNegtive()), SLOT(translateZNegtive()));
	new QShortcut(QKeySequence("E"), this, SLOT(translateZPositive()), SLOT(translateZPositive()));

	new QShortcut(QKeySequence("Ctrl+A"), this, SLOT(rotateXNegtive()), SLOT(rotateXNegtive()));
	new QShortcut(QKeySequence("Ctrl+D"), this, SLOT(rotateXPositive()), SLOT(rotateXPositive()));
	new QShortcut(QKeySequence("Ctrl+S"), this, SLOT(rotateYNegtive()), SLOT(rotateYNegtive()));
	new QShortcut(QKeySequence("Ctrl+W"), this, SLOT(rotateYPositive()), SLOT(rotateYPositive()));
	new QShortcut(QKeySequence("Ctrl+Q"), this, SLOT(rotateZNegtive()), SLOT(rotateZNegtive()));
	new QShortcut(QKeySequence("Ctrl+E"), this, SLOT(rotateZPositive()), SLOT(rotateZPositive()));
}

void ModelEditWidget::readConfig()
{
	QFile file(CONFIGFILE);
	if (file.open(QIODevice::ReadOnly)) {
		QByteArray json = file.readAll();
		QJsonObject obj = QJsonDocument::fromJson(QString(json).toUtf8()).object();
		CROSSSECTIONIMG = obj["crosssection_image"].toString().toStdString();
	}
}

void ModelEditWidget::createFormGroupBox()
{
	editBox = new QGroupBox("模型编辑");
	QFormLayout *layout = new QFormLayout;
	QSlider *slider = new QSlider(Qt::Horizontal);
	QPushButton *unpickButton = new QPushButton("取消选择全部");
	QPushButton *deleteButton = new QPushButton("删除选择");
	QPushButton *saveButton = new QPushButton("保存");
	slider->setMinimum(1);
	slider->setMaximum(100);
	slider->setValue(sliderValue);
	layout->addRow(new QLabel("缩放"), slider);
	layout->addRow(new QLabel("选择状态"), unpickButton);
	layout->addRow(new QLabel("平移X"), new QLabel("A/D"));
	layout->addRow(new QLabel("平移Y"), new QLabel("W/S"));
	layout->addRow(new QLabel("平移Z"), new QLabel("Q/E"));
	layout->addRow(new QLabel("旋转X"), new QLabel("CTRL + A/D"));
	layout->addRow(new QLabel("旋转Y"), new QLabel("CTRL + W/S"));
	layout->addRow(new QLabel("旋转Z"), new QLabel("CTRL + Q/E"));
	layout->addRow(deleteButton, saveButton);
	editBox->setLayout(layout);

	connect(slider, SIGNAL(valueChanged(int)), this, SLOT(scale(int)));
	connect(unpickButton, SIGNAL(clicked()), this, SLOT(dropAllPickedNodes()));
	connect(deleteButton, SIGNAL(clicked()), this, SLOT(deletePickedNodes()));
	connect(saveButton, SIGNAL(clicked()), this, SLOT(save()));

	coordinateBox = new QGroupBox("坐标系视图");
	QHBoxLayout *layout2 = new QHBoxLayout;
	layout2->addWidget(coordinateWidget);
	coordinateBox->setLayout(layout2);

	analysisBox = new QGroupBox("线分析工具");
	QFormLayout *analysisBoxLayout = new QFormLayout;
	startPointLabel = new QLabel("(0, 0, 0)");
	endPointLabel = new QLabel("(0, 0, 0)");
	distanceLabel = new QLabel("0米");
	markLineEdit = new QLineEdit();		//实例化markLineEdit 添加的代码
	markLineEdit->setPlaceholderText("请输入标记注释");	//添加的代码
	QPushButton *startPointButton = new QPushButton("选择起点");
	QPushButton *endPointButton = new QPushButton("选择终点");
	QPushButton *crossSectionButton = new QPushButton("测量距离");
	QPushButton *addMarkButton = new QPushButton("添加标注");
	analysisBoxLayout->addRow(startPointButton, startPointLabel);
	analysisBoxLayout->addRow(endPointButton, endPointLabel);
	analysisBoxLayout->addRow(crossSectionButton, distanceLabel);
	analysisBoxLayout->addRow(addMarkButton, markLineEdit);	//添加markLineEdit

	connect(startPointButton, SIGNAL(clicked()), this, SLOT(onStartPointButtonClicked()));
	connect(endPointButton, SIGNAL(clicked()), this, SLOT(onEndPointButtonClicked()));
	connect(crossSectionButton, SIGNAL(clicked()), this, SLOT(ondistanceLabel()));
	connect(addMarkButton, SIGNAL(clicked()), this, SLOT(addNewMark()));

	analysisBox->setLayout(analysisBoxLayout);

	rect_analysisBox = new QGroupBox("图形分析工具");
	QFormLayout *rect_analysisBoxLayout = new QFormLayout;
	rect_startPointLabel = new QLabel("(0, 0, 0)");
	rect_midPointLabel = new QLabel("(0, 0, 0)");
	rect_endPointLabel = new QLabel("(0, 0, 0)");
	areaLabel = new QLabel("0平方米");
	QPushButton *rect_startPointButton = new QPushButton("选择起点");
	QPushButton *rect_midPointButton = new QPushButton("选择中间点");
	QPushButton *rect_endPointButton = new QPushButton("选择终点");
	QPushButton *rect_crossSectionButton = new QPushButton("测量面积");
	rect_analysisBoxLayout->addRow(rect_startPointButton, rect_startPointLabel);
	rect_analysisBoxLayout->addRow(rect_midPointButton, rect_midPointLabel);
	rect_analysisBoxLayout->addRow(rect_endPointButton, rect_endPointLabel);
	rect_analysisBoxLayout->addRow(rect_crossSectionButton, areaLabel);

	connect(rect_startPointButton, SIGNAL(clicked()), this, SLOT(onRectStartPointButtonClicked()));//需要新建
	connect(rect_midPointButton, SIGNAL(clicked()), this, SLOT(onRectMidPointButtonClicked()));//需要新建
	connect(rect_endPointButton, SIGNAL(clicked()), this, SLOT(onRectEndPointButtonClicked()));//需要新建
	connect(rect_crossSectionButton, SIGNAL(clicked()), this, SLOT(onareaLabel()));//需要新建

	rect_analysisBox->setLayout(rect_analysisBoxLayout);
}

void ModelEditWidget::addPickedNode(osg::Node* node)
{
	if (node->getNumParents() > 0) {
		m_pickedNodes.insert(node);
		Node *child = dynamic_cast<osgFX::Scribe*>(node)->getChild(0);
		string name = child->getName();
		pickedMineLengthSum += mineNetwork->getLengthByMineName(name);
		emit pickedMineLengthSumChanged(QString::number(pickedMineLengthSum * 10) + "米");
	}
}

void ModelEditWidget::dropPickedNode(osg::Node* node)
{
	auto it = m_pickedNodes.find(node);
	if (it != m_pickedNodes.end()) {
		m_pickedNodes.erase(it);

		Node *child = dynamic_cast<osgFX::Scribe*>(node)->getChild(0);
		string name = child->getName();
		pickedMineLengthSum -= mineNetwork->getLengthByMineName(name);
		emit pickedMineLengthSumChanged(QString::number(pickedMineLengthSum * 10) + "米");
	}
}

void ModelEditWidget::dropAllPickedNodes()
{
	for (Node *n : m_pickedNodes) {
		ref_ptr<osgFX::Scribe> node = dynamic_cast<osgFX::Scribe*>(n);
		ref_ptr<Group> parent = node->getParent(0);
		ref_ptr<Node> child = node->getChild(0);
		parent->replaceChild(node, child);
	}
	m_pickedNodes.clear();
	pickedMineLengthSum = 0;
	emit pickedMineLengthSumChanged("0米");
}

void ModelEditWidget::deletePickedNodes()
{
	for (Node *n : m_pickedNodes) {
		ref_ptr<osgFX::Scribe> node = dynamic_cast<osgFX::Scribe*>(n);
		ref_ptr<Group> parent = node->getParent(0);
		ref_ptr<Node> child = node->getChild(0);
		string name = child->getName();
		parent->removeChild(node);
	}
	m_pickedNodes.clear();
	pickedMineLengthSum = 0;
	emit pickedMineLengthSumChanged("0米");
}

void ModelEditWidget::scale(int value)
{
	double factor = static_cast<double>(value) / sliderValue;
	sliderValue = value;
	if (!m_pickedNodes.empty()) {
		for (Node *n : m_pickedNodes) {
			ref_ptr<Node> node = n;
			ref_ptr<Group> parent = node->getParent(0);
			ref_ptr<PositionAttitudeTransform> parentAsPAT = dynamic_cast<PositionAttitudeTransform*>(parent.get());
			if (!parentAsPAT) {
				ref_ptr<PositionAttitudeTransform> pat = new PositionAttitudeTransform;
				pat->setScale(Vec3d(factor, factor, factor));
				pat->addChild(node);
				parent->replaceChild(node, pat);
			}
			else {
				Vec3d scale = parentAsPAT->getScale();
				scale *= factor;
				parentAsPAT->setScale(scale);
			}
		}
	}
}

void ModelEditWidget::save()
{
	dropAllPickedNodes();
	emit saveSceneData();
}

void ModelEditWidget::translateXNegtive()
{
	translate(Vec3d(-1, 0, 0));
}

void ModelEditWidget::translateXPositive()
{
	translate(Vec3d(1, 0, 0));
}

void ModelEditWidget::translateYNegtive()
{
	translate(Vec3d(0, -1, 0));
}

void ModelEditWidget::translateYPositive()
{
	translate(Vec3d(0, 1, 0));
}

void ModelEditWidget::translateZNegtive()
{
	translate(Vec3d(0, 0, -1));
}

void ModelEditWidget::translateZPositive()
{
	translate(Vec3d(0, 0, 1));
}

void ModelEditWidget::translate(Vec3d t)
{
	if (!m_pickedNodes.empty()) {
		for (Node *n : m_pickedNodes) {
			ref_ptr<Node> node = n;
			ref_ptr<Group> parent = node->getParent(0);
			ref_ptr<PositionAttitudeTransform> parentAsPAT = dynamic_cast<PositionAttitudeTransform*>(parent.get());
			if (!parentAsPAT) {
				ref_ptr<PositionAttitudeTransform> pat = new PositionAttitudeTransform;
				pat->setPosition(t);
				pat->addChild(node);
				parent->replaceChild(node, pat);
			}
			else {
				Vec3d translate = parentAsPAT->getPosition();
				translate += t;
				parentAsPAT->setPosition(translate);
			}
		}
	}
}

void ModelEditWidget::rotateXNegtive()
{
	rotate(-rotateDelta, 0, 0);
}

void ModelEditWidget::rotateXPositive()
{
	rotate(rotateDelta, 0, 0);
}

void ModelEditWidget::rotateYNegtive()
{
	rotate(0, -rotateDelta, 0);
}

void ModelEditWidget::rotateYPositive()
{
	rotate(0, rotateDelta, 0);
}

void ModelEditWidget::rotateZNegtive()
{
	rotate(0, 0, -rotateDelta);
}

void ModelEditWidget::rotateZPositive()
{
	rotate(0, 0, rotateDelta);
}

void ModelEditWidget::rotate(double dx, double dy, double dz)
{
	if (!m_pickedNodes.empty()) {
		for (Node *n : m_pickedNodes) {
			ref_ptr<Node> node = n;
			ref_ptr<Group> parent = node->getParent(0);
			ref_ptr<PositionAttitudeTransform> parentAsPAT = dynamic_cast<PositionAttitudeTransform*>(parent.get());
			if (!parentAsPAT) {
				ref_ptr<PositionAttitudeTransform> pat = new PositionAttitudeTransform;
				Quat q;
				q.makeRotate(dx, Vec3(1, 0, 0), dy, Vec3(0, 1, 0), dz, Vec3(0, 0, 1));
				pat->setAttitude(q);
				pat->addChild(node);
				parent->replaceChild(node, pat);
			}
			else {
				Quat second = parentAsPAT->getAttitude();
				Quat first;
				first.makeRotate(dx, Vec3(1, 0, 0), dy, Vec3(0, 1, 0), dz, Vec3(0, 0, 1));
				Quat q = second * first;
				parentAsPAT->setAttitude(q);
			}
		}
	}
}

QtOSGWidget* ModelEditWidget::getCoordinateWidget()
{
	return coordinateWidget;
}


void ModelEditWidget::onStartPointButtonClicked()
{
	activePoint = STARTPOINT;
}

void ModelEditWidget::onEndPointButtonClicked()
{
	activePoint = ENDPOINT;
}

void ModelEditWidget::onRectStartPointButtonClicked()
{
	activePoint = RECT_STARTPOINT;
}

void ModelEditWidget::onRectMidPointButtonClicked()
{
	activePoint = RECT_MIDPOINT;
}

void ModelEditWidget::onRectEndPointButtonClicked()
{
	activePoint = RECT_ENDPOINT;
}

void ModelEditWidget::addNewMark()
{
	//添加判断markLineEdit是否为空的逻辑
	qDebug() << markLineEdit->text();
	if (markLineEdit->text() == "")
	{
		QMessageBox::information(NULL, "添加标注", "注释不能为空！");
		return;
	}
	proActivePoint = activePoint;
	activePoint = 8;
}

void ModelEditWidget::ondistanceLabel()
{
	string startPoint = startPointLabel->text().toStdString();
	string endPoint = endPointLabel->text().toStdString();
	stringstream ss(startPoint);
	stringstream es(endPoint);
	char x;
	double x1, y1, z1, x2, y2, z2;
	ss >> x >> x1 >> x >> y1 >> x >> z1 >> x;
	es >> x >> x2 >> x >> y2 >> x >> z2 >> x;
	qDebug() << x1 << y1 << z1 << ";" << x2 << y2 << z2;
	QString distance = QString::number(sqrt((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) + (z1 - z2)*(z1 - z2))) + "米";
	distanceLabel->setText(distance);
	QString point1 = "(" + QString::number(x1, 'f', 2) + ", " + QString::number(y1, 'f', 2) + ", " + QString::number(z1, 'f', 2) + ")";
	QString point2 = "(" + QString::number(x2, 'f', 2) + ", " + QString::number(y2, 'f', 2) + ", " + QString::number(z2, 'f', 2) + ")";
	QString markLableNote = markLineEdit->text();
	QSqlQuery query;
	QString sqlStr = "insert into distance (Position1, Position2, distance, create_time) values('" + point1 + "','" + point2 + "','" + distance + "', now())";
	qDebug() << sqlStr;
	query.exec(sqlStr);
}

void ModelEditWidget::onareaLabel()
{
	//计算面积
	string rect_startPoint = rect_startPointLabel->text().toStdString();
	string rect_midPoint = rect_midPointLabel->text().toStdString();
	string rect_endPoint = rect_endPointLabel->text().toStdString();
	stringstream ss(rect_startPoint);
	stringstream ms(rect_midPoint);
	stringstream es(rect_endPoint);
	char x;
	double x1, y1, z1, x2, y2, z2, x3, y3, z3;
	ss >> x >> x1 >> x >> y1 >> x >> z1 >> x;
	ms >> x >> x2 >> x >> y2 >> x >> z2 >> x;
	es >> x >> x3 >> x >> y3 >> x >> z3 >> x;
	qDebug() << x1 << y1 << z1 << ";" << x2 << y2 << z2 << ";" << x3 << y3 << z3;

	//计算三角形面积，四边形则乘2
	double side[3];//存储三条边的长度;
	side[0] = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2) + pow(z1 - z2, 2));
	side[1] = sqrt(pow(x1 - x3, 2) + pow(y1 - y3, 2) + pow(z1 - z3, 2));
	side[2] = sqrt(pow(x3 - x2, 2) + pow(y3 - y2, 2) + pow(z3 - z2, 2));
	//利用海伦公式。s=sqr(p*(p-a)(p-b)(p-c)); 
	double p = (side[0] + side[1] + side[2]) / 2; //半周长;
	double triangle_area = sqrt(p*(p - side[0])*(p - side[1])*(p - side[2]));

	QString area = QString::number(triangle_area) + "平方米";
	areaLabel->setText(area);

	//插入数据库
	QString point1 = "(" + QString::number(x1, 'f', 2) + ", " + QString::number(y1, 'f', 2) + ", " + QString::number(z1, 'f', 2) + ")";
	QString point2 = "(" + QString::number(x2, 'f', 2) + ", " + QString::number(y2, 'f', 2) + ", " + QString::number(z2, 'f', 2) + ")";
	QString point3 = "(" + QString::number(x3, 'f', 2) + ", " + QString::number(y3, 'f', 2) + ", " + QString::number(z3, 'f', 2) + ")";
	QSqlQuery query;
	QString sqlStr = "insert into area (position1, position2, position3, area, create_time) values('" + point1 + "','" + point2 + "','" + point3 + "','" + area + "', now())";
	qDebug() << sqlStr;
	query.exec(sqlStr);
}

void ModelEditWidget::selectGroundPoint(Vec3 point)
{
	//添加处理鼠标点击坐标的代码
	qDebug() << "鼠标点击坐标：(" << point.x() << "," << point.y() << "," << point.z() << ")";
	QString markNote = getMarkNote(point);
	if (markNote != NULL)
	{
		markLineEdit->setText(markNote);
	}

	if (activePoint == STARTPOINT) {
		startPoint = point;
		crossSectionPoints |= STARTPOINT;
		startPointLabel->setText("(" + QString::number(startPoint.x() * 0.001) + ", " + QString::number(startPoint.y() * 0.001) + ", " + QString::number(startPoint.z() * 0.001) + ")");
	}
	else if (activePoint == ENDPOINT){
		endPoint = point;
		crossSectionPoints |= ENDPOINT;
		endPointLabel->setText("(" + QString::number(endPoint.x() * 0.001) + ", " + QString::number(endPoint.y() * 0.001) + ", " + QString::number(endPoint.z() * 0.001) + ")");
	}
	else if (activePoint == RECT_STARTPOINT){
		rect_startPoint = point;
		rect_crossSectionPoints |= RECT_STARTPOINT;
		rect_startPointLabel->setText("(" + QString::number(rect_startPoint.x() * 0.001) + ", " + QString::number(rect_startPoint.y() * 0.001) + ", " + QString::number(rect_startPoint.z() * 0.001) + ")");
	}
	else if (activePoint == RECT_MIDPOINT){
		rect_midPoint = point;
		rect_crossSectionPoints |= RECT_MIDPOINT;
		rect_midPointLabel->setText("(" + QString::number(rect_midPoint.x() * 0.001) + ", " + QString::number(rect_midPoint.y() * 0.001) + ", " + QString::number(rect_midPoint.z() * 0.001) + ")");
	}
	else if (activePoint == RECT_ENDPOINT){
		rect_endPoint = point;
		rect_crossSectionPoints |= RECT_ENDPOINT;
		rect_endPointLabel->setText("(" + QString::number(rect_endPoint.x() * 0.001) + ", " + QString::number(rect_endPoint.y() * 0.001) + ", " + QString::number(rect_endPoint.z() * 0.001) + ")");
	}
	//测距-画线
	if (crossSectionPoints == BOTHPOINTS) {
		if (scene->containsNode(crossSectionGeode)) {
			scene->removeChild(crossSectionGeode);
			crossSectionGeode = new Geode;
		}
		ref_ptr<Geometry> geom = new Geometry;
		ref_ptr<Vec3Array> vertexArray = new Vec3Array;
		vertexArray->push_back(startPoint);
		vertexArray->push_back(endPoint);
		ref_ptr<Vec4Array> color = new Vec4Array;
		color->push_back(Vec4(1.0, 1.0, 1.0, 1.0));
		geom->setVertexArray(vertexArray);
		geom->setColorArray(color);
		geom->setColorBinding(Geometry::BIND_OVERALL);
		ref_ptr<osg::LineWidth> lineWidth = new LineWidth(2.0f);
		geom->getOrCreateStateSet()->setAttributeAndModes(lineWidth, osg::StateAttribute::ON);
		geom->addPrimitiveSet(new DrawArrays(GL_LINES, 0, 2));

		crossSectionGeode->addChild(geom);
		crossSectionGeode->getOrCreateStateSet()->setMode(GL_LIGHTING, StateAttribute::OFF);

		scene->addChild(crossSectionGeode);
	}
	//测面积-画线
	if (rect_crossSectionPoints == ALLPOINTS) {//7
		if (scene->containsNode(rect_crossSectionGeode)) {
			scene->removeChild(rect_crossSectionGeode);
			rect_crossSectionGeode = new Geode;
		}

		//start->mid
		ref_ptr<Geometry> geom = new Geometry;
		ref_ptr<Vec3Array> vertexArray = new Vec3Array;
		vertexArray->push_back(rect_startPoint);//here changed
		vertexArray->push_back(rect_midPoint);//here changed
		ref_ptr<Vec4Array> color = new Vec4Array;
		color->push_back(Vec4(1.0, 1.0, 1.0, 1.0));
		geom->setVertexArray(vertexArray);
		geom->setColorArray(color);
		geom->setColorBinding(Geometry::BIND_OVERALL);
		ref_ptr<osg::LineWidth> lineWidth = new LineWidth(2.0f);
		geom->getOrCreateStateSet()->setAttributeAndModes(lineWidth, osg::StateAttribute::ON);
		geom->addPrimitiveSet(new DrawArrays(GL_LINES, 0, 2));
		rect_crossSectionGeode->addChild(geom);
		rect_crossSectionGeode->getOrCreateStateSet()->setMode(GL_LIGHTING, StateAttribute::OFF);
		scene->addChild(rect_crossSectionGeode);

		//mid->end
		ref_ptr<Geometry> geom_2 = new Geometry;
		ref_ptr<Vec3Array> vertexArray_2 = new Vec3Array;
		vertexArray_2->push_back(rect_midPoint);//here changed
		vertexArray_2->push_back(rect_endPoint);//here changed
		geom_2->setVertexArray(vertexArray_2);
		geom_2->setColorArray(color);
		geom_2->setColorBinding(Geometry::BIND_OVERALL);
		geom_2->getOrCreateStateSet()->setAttributeAndModes(lineWidth, osg::StateAttribute::ON);
		geom_2->addPrimitiveSet(new DrawArrays(GL_LINES, 0, 2));
		rect_crossSectionGeode->addChild(geom_2);
		rect_crossSectionGeode->getOrCreateStateSet()->setMode(GL_LIGHTING, StateAttribute::OFF);
		scene->addChild(rect_crossSectionGeode);

		//end->start
		ref_ptr<Geometry> geom_3 = new Geometry;
		ref_ptr<Vec3Array> vertexArray_3 = new Vec3Array;
		vertexArray_3->push_back(rect_endPoint);//here changed
		vertexArray_3->push_back(rect_startPoint);//here changed
		geom_3->setVertexArray(vertexArray_3);
		geom_3->setColorArray(color);
		geom_3->setColorBinding(Geometry::BIND_OVERALL);
		geom_3->getOrCreateStateSet()->setAttributeAndModes(lineWidth, osg::StateAttribute::ON);
		geom_3->addPrimitiveSet(new DrawArrays(GL_LINES, 0, 2));
		rect_crossSectionGeode->addChild(geom_3);
		rect_crossSectionGeode->getOrCreateStateSet()->setMode(GL_LIGHTING, StateAttribute::OFF);
		scene->addChild(rect_crossSectionGeode);

		rect_crossSectionPoints = 0;
	}
	if (activePoint == 8){
		markPoint = point;
		qsrand(QTime(0, 0, 0).secsTo(QTime::currentTime()));
		int test = qrand() % 100;
		QString markName = "M" + QString::number(test);  //用于作为mark的name，可随意
		QString markpoint = "(" + QString::number(markPoint.x() * 0.001) + ", " + QString::number(markPoint.y() * 0.001) + ", " + QString::number(markPoint.z() * 0.001) + ")";
		QString markLableNote = markLineEdit->text();
		QSqlQuery query;
		QString sqlStr = "insert into mark (name, point, note, create_time) values('" + markName + "','" + markpoint + "','"+ markLableNote + "', now())";
		qDebug() << sqlStr;
		query.exec(sqlStr);

		ref_ptr<Group> geode(new Group);
		geode->setName(markName.toStdString());

		Vec3d v(markPoint.x(), markPoint.y(), markPoint.z() + 5);
		osg::ref_ptr<osg::Node> mark = osgDB::readNodeFile("mark.ive");

		osg::ref_ptr<osg::PositionAttitudeTransform> pat = new osg::PositionAttitudeTransform();
		pat->setPosition(v);
		pat->setScale(osg::Vec3(0.065f, 0.065f, 0.065f));
		pat->addChild(mark.get());
		geode->addChild(pat.get());

		scene->addChild(geode);
		osgWidget->getViewer()->setSceneData(scene);

		activePoint = proActivePoint;
	}
}

void ModelEditWidget::crossSection()
{
	ref_ptr<Geode> geode(new Geode);

	Plane plane;
	Polytope boundingPolytope;
	osg::Vec3d upVector(0.0, 0.0, 1.0);

	// 构造求交平面（点法式）
	osg::Vec3d planeNormal = (endPoint - startPoint) ^ upVector;
	planeNormal.normalize();
	plane.set(planeNormal, startPoint);

	// 第一个约束面
	osg::Vec3d startPlaneNormal = upVector ^ planeNormal;
	startPlaneNormal.normalize();
	boundingPolytope.add(osg::Plane(startPlaneNormal, startPoint));

	// 第二个约束面
	osg::Vec3d endPlaneNormal = planeNormal ^ upVector;
	endPlaneNormal.normalize();
	boundingPolytope.add(osg::Plane(endPlaneNormal, endPoint));

	//构造平面求交器
	ref_ptr<osgUtil::PlaneIntersector> intersector = new osgUtil::PlaneIntersector(plane, boundingPolytope);
	osgUtil::IntersectionVisitor intersectionVisitor;
	intersectionVisitor.reset();
	intersectionVisitor.setIntersector(intersector.get());

	scene->accept(intersectionVisitor);

	osgUtil::PlaneIntersector::Intersections& intersections = intersector->getIntersections();
	//对结果进行变换（局部坐标转到世界坐标）
	for (osgUtil::PlaneIntersector::Intersections::iterator itr = intersections.begin(); itr != intersections.end(); ++itr) {
		osgUtil::PlaneIntersector::Intersection& intersection = *itr;

		if (intersection.matrix.valid()) {
			for (auto pitr = intersection.polyline.begin(); pitr != intersection.polyline.end(); ++pitr) {
				*pitr = (*pitr) * (*intersection.matrix);
			}
			// matrix no longer needed.
			intersection.matrix = nullptr;
		}
	}

	for (auto it = intersections.begin(); it != intersections.end(); ++it) {
		auto &intersection = *it;

		NodePath &nodePath = intersection.nodePath;
		ref_ptr<Node> node = (nodePath.size() >= 1) ? nodePath[nodePath.size() - 1] : nullptr;
		double radius = 0;
		if (node) {
			string name = node->getName();
			radius = mineNetwork->getRadiusByMineName(name);
		}

		ref_ptr<Geometry> geom = new Geometry;
		ref_ptr<Vec3Array> vertexArray = new Vec3Array;
		Vec3d center;
		for (auto pit = intersection.polyline.begin(); pit != intersection.polyline.end(); ++pit) {
			vertexArray->push_back(*pit);
			if (radius != 0) {
				center += *pit;
			}
		}
		center /= vertexArray->size();

		geom->setVertexArray(vertexArray);
		ref_ptr<Vec4Array> colorArray = new Vec4Array();
		colorArray->push_back(Vec4(1.0, 0.0, 0.0, 1.0));
		geom->setColorArray(colorArray);
		geom->setColorBinding(Geometry::BIND_OVERALL);
		ref_ptr<osg::LineWidth> lineWidth = new LineWidth(2.0f);
		geom->getOrCreateStateSet()->setAttributeAndModes(lineWidth, osg::StateAttribute::ON);
		ref_ptr<DrawArrays> drawArray = new DrawArrays(DrawArrays::LINE_STRIP, 0, vertexArray->size());
		geom->addPrimitiveSet(drawArray);
		geode->addChild(geom);
	}

	Vec3d midPoint = (startPoint + endPoint) / 2;
	double length = (endPoint - startPoint).length() / 2;
	Vec3d viewPoint = midPoint + (planeNormal * length);
	ref_ptr<Camera> camera = new Camera;
	camera->setViewMatrixAsLookAt(viewPoint, midPoint, upVector);
	camera->setProjectionMatrixAsPerspective(90.0, 1.0, 1.0, 1000.0);

	ref_ptr<Group> group = new Group;
	group->addChild(geode);
	qDebug() << CROSSSECTIONIMG.c_str();
	renderSceneToImage(group, CROSSSECTIONIMG, 600, 600, camera->getProjectionMatrix(), camera->getViewMatrix());
	QMessageBox::about(this, "保存", "保存剖面图成功");

	if (scene->containsNode(crossSectionGeode)) {
		scene->removeChild(crossSectionGeode);
		crossSectionGeode = new Geode;
	}
	if (scene->containsNode(rect_crossSectionGeode)) {
		scene->removeChild(rect_crossSectionGeode);
		rect_crossSectionGeode = new Geode;
	}
}

QString ModelEditWidget::getMarkNote(osg::Vec3d point)
{
	double x = point.x() * 10, y = point.y() * 10;
	double z = (point.z() - 5) * 10; 
	double distance = 300.0;		
	QString returnNote = "";
	QSqlQuery query;
	QString sqlstr = "select point, note from mark;";
	query.exec(sqlstr);
	while (query.next())
	{
		string points = query.value(0).toString().toStdString();
		string note = query.value(1).toString().toStdString();
		stringstream ss(points);
		char c;
		double x2, y2, z2, distance2;
		ss >> c >> x2 >> c >> y2 >> c >> z2;
		distance2 = (x - x2)*(x - x2) + (y - y2)*(y - y2) + (z - z2)*(z - z2);
		if (distance2 < distance)
		{
			distance = distance2;
			returnNote = QString::fromStdString(note);
		}
	}
	return returnNote;
}
