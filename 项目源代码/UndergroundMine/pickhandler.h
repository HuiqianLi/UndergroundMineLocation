#ifndef PICKHANDLER_H
#define PICKHANDLER_H


#include <QObject>
#include <Windows.h>
#include <osgGA/GUIEventHandler>
#include <osgFX/Scribe>
#include <osgText/Text>
#include <osgText/Font>
#include <osgViewer/Viewer>
#include <osg/Material>
#include <osg/Geode>
#include <osg/BlendFunc>
#include <osg/Depth>
#include <osg/Projection>
#include <osg/MatrixTransform>
#include <osg/Camera>
#include <osg/io_utils>
#include <osgText/Text>

#include <string>

#pragma execution_character_set("utf-8")

class PickHandler : public QObject, public osgGA::GUIEventHandler
{
     Q_OBJECT

public:
    PickHandler(QObject *parent = nullptr);

    bool handle(const osgGA::GUIEventAdapter &ea, osgGA::GUIActionAdapter &aa);

    virtual void pick(osg::ref_ptr<osgViewer::Viewer> viewer, const osgGA::GUIEventAdapter &ea);

    virtual void pick(osg::ref_ptr<osgViewer::Viewer> viewer, float x, float y);

    osg::ref_ptr<osg::Node> getHUD();
    osg::ref_ptr<osgText::Text> getText();

signals:
    void picked(const std::string &name);
    void picked(osg::Node* node);
    void unPicked(osg::Node* node);
    void selectGroundPoint(osg::Vec3 point);

protected:
    // 得到当前视图矩阵
    osg::Vec3 position;
    osg::Vec3 center;
    osg::Vec3 up;

private:
    osg::ref_ptr<osgText::Text> text;
    osg::ref_ptr<osg::Node> hud;
    float click_x, click_y;

    void createHUD();
};

#endif // PICKHANDLER_H
