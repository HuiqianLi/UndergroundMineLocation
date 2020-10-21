#ifndef MODELEDITWIDGET_H
#define MODELEDITWIDGET_H

#include "qtosgwidget.h"
#include "network3d.h"
#include <Windows.h>
#include <QWidget>
#include <QGroupBox>
#include <qlineedit.h>
#include <QDialogButtonBox>

#include <osg/Node>
#include <osg/Geode>

#include <list>
#include <unordered_set>

#pragma execution_character_set("utf-8")

class QLabel;

class ModelEditWidget : public QWidget
{
	Q_OBJECT
public:
	explicit ModelEditWidget(QWidget *parent = nullptr, Network3D *network = nullptr, osg::Group *scene = nullptr, QtOSGWidget *osgWidget = nullptr);

	QtOSGWidget* getCoordinateWidget();

	enum { STARTPOINT = 1, ENDPOINT = 2, BOTHPOINTS = 3, RECT_STARTPOINT = 4, RECT_MIDPOINT = 5, RECT_ENDPOINT = 6, ALLPOINTS = 7 };

signals:
	void saveSceneData();
	void pickedMineLengthSumChanged(const QString &val);

	public slots:
	void addPickedNode(osg::Node* node);
	void dropPickedNode(osg::Node* node);
	void dropAllPickedNodes();
	void deletePickedNodes();
	void scale(int value);
	void translateXNegtive();
	void translateXPositive();
	void translateYNegtive();
	void translateYPositive();
	void translateZNegtive();
	void translateZPositive();
	void rotateXNegtive();
	void rotateXPositive();
	void rotateYNegtive();
	void rotateYPositive();
	void rotateZNegtive();
	void rotateZPositive();
	void save();

	void onStartPointButtonClicked();
	void onEndPointButtonClicked();
	void onRectStartPointButtonClicked();
	void onRectMidPointButtonClicked();
	void onRectEndPointButtonClicked();
	void onareaLabel();
	void ondistanceLabel();
	void selectGroundPoint(osg::Vec3 point);
	void crossSection();
	void addNewMark();

private:
	const QString CONFIGFILE = "config.json";
	std::string CROSSSECTIONIMG = "D:/crosssectionimage.bmp";

	Network3D *mineNetwork;
	osg::ref_ptr<osg::Group> scene;

	QtOSGWidget *coordinateWidget;
	QtOSGWidget *osgWidget;
	QLineEdit *markLineEdit;	//注意代码添加的位置
	
	QGroupBox *editBox, *coordinateBox, *analysisBox, *rect_analysisBox;
	QLabel *startPointLabel, *endPointLabel, *distanceLabel, *rect_startPointLabel, *rect_midPointLabel, *rect_endPointLabel, *areaLabel;
	osg::Vec3d startPoint, endPoint, markPoint, rect_startPoint, rect_midPoint, rect_endPoint;
	int activePoint = STARTPOINT;
	int crossSectionPoints = 0;
	int rect_crossSectionPoints = 0;
	int proActivePoint = 0;
	osg::ref_ptr<osg::Geode> crossSectionGeode;
	osg::ref_ptr<osg::Geode> rect_crossSectionGeode;
	std::unordered_set<osg::Node*> m_pickedNodes;
	int sliderValue = 20;
	double rotateDelta = osg::PI / 180;
	double pickedMineLengthSum = 0;

	void createFormGroupBox();
	void translate(osg::Vec3d t);
	void rotate(double dx, double dy, double dz);
	void readConfig();
	QString getMarkNote(osg::Vec3d point);		//获得鼠标点击坐标处的标记的注释
	
};



#endif // MODELEDITWIDGET_H
