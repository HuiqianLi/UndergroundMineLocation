#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QtWidgets/QMainWindow>
#include <QSqlDatabase>
#include <Windows.h>
#include "qtosgwidget.h"
#include "modeleditwidget.h"
#include "pickhandler.h"
#include "wanderhandler.h"
#include "network3d.h"

#include <osg/Node>
#include <osgViewer/Viewer>
#include <osgUtil/Optimizer>

#pragma execution_character_set("utf-8")

class MainWindow : public QMainWindow
{
	Q_OBJECT

public:
	MainWindow(QWidget *parent = nullptr);
	~MainWindow();

	public slots:
	void saveSceneData();

private:
	// configuration
	const QString CONFIGFILE = "config.json";
	const char* DATAFILE = "main.ive";
	QString scene_file;
	QString odbc_name = "test3";
	QString db_host = "127.0.0.1";
	QString db_user = "root";
	QString db_password = "123456";

	QSqlDatabase db;
	QtOSGWidget *osgWidget;
	ModelEditWidget *modelEditWidget;
	PickHandler *pickHandler;
	WanderHandler *wanderHandler;
	QToolBar *toolbar;
	osgUtil::Optimizer optimizer;
	Network3D mineNetwork;
	osg::ref_ptr<osg::Group> scene;
	osg::ref_ptr<osg::Group> mine_group;
	osg::ref_ptr<osg::Group> valve_group;

	void createLayout();
	void createToolbar();
	void initDatabase();
	osg::ref_ptr<osg::Group> initScene();
	osg::ref_ptr<osg::Group> loadMarkFromDB();
	void readConfig();
};

#endif // MAINWINDOW_H
