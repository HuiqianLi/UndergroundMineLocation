#include "pickhandler.h"
#include <string>
#include <sstream>

#include <QDebug>

#include <osgGA/OrbitManipulator> //

using namespace osg;
using namespace std;

PickHandler::PickHandler(QObject *parent) : QObject(parent)
{
    createHUD();
    click_x = click_y = 0;
}

void PickHandler::createHUD()
{
    // 创建一个相机
    ref_ptr<Camera> hudCamera = new Camera;
    // 设置绝对帧引用
    hudCamera->setReferenceFrame(Transform::ABSOLUTE_RF);
    // 设置正投影矩阵
    hudCamera->setProjectionMatrixAsOrtho2D(0, 1280, 0, 1024);
    // 设置视图矩阵
    hudCamera->setViewMatrix(Matrix::identity());
    // 设置渲染顺序为POST
    hudCamera->setRenderOrder(Camera::POST_RENDER);
    // 清除深度缓存
    hudCamera->setClearMask(GL_DEPTH_BUFFER_BIT);
    // 设置字体
    ref_ptr<osgText::Font> font = osgText::readFontFile("simhei.ttf");
    // 设置位置
    Vec3 position(200, 900, 0);

    ref_ptr<Geode> geode = new Geode;
    ref_ptr<StateSet> stateset = geode->getOrCreateStateSet();
    // 关闭光照
    stateset->setMode(GL_LIGHTING, StateAttribute::OFF);
    // 关闭深度测试
    stateset->setMode(GL_DEPTH_TEST, StateAttribute::OFF);

    text = new osgText::Text;
//    text->setFont(font.get());
    text->setCharacterSize(20);
    text->setColor(Vec4(1, 1, 1, 1));
    text->setText("");
    text->setPosition(position);
    // 设置数据变量为DYNAMIC
    text->setDataVariance(Object::DYNAMIC);

    geode->addDrawable(text);
    hudCamera->addChild(geode);

    hud = hudCamera;
}

bool PickHandler::handle(const osgGA::GUIEventAdapter &ea, osgGA::GUIActionAdapter &aa)
{
    ref_ptr<osgViewer::Viewer> viewer = dynamic_cast<osgViewer::Viewer*>(&aa);
    if (!viewer) {
        return false;
    }

    switch (ea.getEventType()) {
    case osgGA::GUIEventAdapter::FRAME:
    {
        // 得到视图矩阵
        viewer->getCamera()->getViewMatrixAsLookAt(position, center, up);
        pick(viewer, ea);
        break;
    }
    case osgGA::GUIEventAdapter::PUSH:
    {
        click_x = ea.getX();
        click_y = ea.getY();
        break;
    }
    case osgGA::GUIEventAdapter::RELEASE:
    {
        if (click_x == ea.getX() && click_y == ea.getY() && ea.getButton() == 1) {
            // 执行对象选取
            pick(viewer, click_x, click_y);
        } else if (click_x == ea.getX() && click_y == ea.getY() && ea.getButton() == 4) {
            // ea.getButton() == 4, but i don't know why.

            // complicated, there may be easier way to find point at Oxy plane
            osgUtil::LineSegmentIntersector::Intersections intersections;
            float x = ea.getX();
            float y = ea.getY();

            if (viewer->computeIntersections(x, y, intersections)) {
                Vec3 point = intersections.begin()->getWorldIntersectPoint();
                //point.z() = 0;
                emit selectGroundPoint(point);
            }
        }
        break;
    }
    default:
        break;
    }
    return false;
}

// 显示位置
void PickHandler::pick(osg::ref_ptr<osgViewer::Viewer> viewer, const osgGA::GUIEventAdapter &ea)
{
    // 创建一个线段交集检测对象
    osgUtil::LineSegmentIntersector::Intersections intersections;

    string gdlist("");
    // 申请一个流
    ostringstream os;
    // 得到鼠标的位置
    float x = ea.getX();
    float y = ea.getY();

    if (viewer->computeIntersections(x, y, intersections)) {
       // 得到相交交集的交点
        for (const osgUtil::LineSegmentIntersector::Intersection &hit : intersections) {
            os << "Mouse in World X: " << hit.getWorldIntersectPoint().x() << " Y: "
               << hit.getWorldIntersectPoint().y() << " Z: " << hit.getWorldIntersectPoint().z() << endl;
        }
    }
    os << "Viewer Position X: " << position[0] << " Y: " << position[1] << " Z: " << position[2] << endl;

    gdlist += os.str();
    // 设置显示内容
//    text->setText(gdlist);
    // commented, for future or debug use
    //qDebug() << gdlist.c_str();
}


// 选择对象
void PickHandler::pick(osg::ref_ptr<osgViewer::Viewer> viewer, float x, float y)
{
    ref_ptr<Node> node = new Node();
    ref_ptr<Group> parent = new Group();

    // 创建一个线段交集检测函数
    osgUtil::LineSegmentIntersector::Intersections intersections;
    if (viewer->computeIntersections(x, y, intersections)) {
        // 选中第一个物体
        osgUtil::LineSegmentIntersector::Intersection intersection = *intersections.begin();
        NodePath &nodePath = intersection.nodePath;
        node = (nodePath.size() >= 1)?nodePath[nodePath.size() - 1]:nullptr;
        parent = (nodePath.size() >= 2)?dynamic_cast<Group*>(nodePath[nodePath.size() - 2]):nullptr;
    }

    // 高亮显示选中物体
    if (parent && node) {
        ref_ptr<osgFX::Scribe> parentAsScribe = dynamic_cast<osgFX::Scribe*>(parent.get());
        if (!parentAsScribe) {
            ref_ptr<osgFX::Scribe> scribe = new osgFX::Scribe();
            scribe->addChild(node);
            parent->replaceChild(node, scribe);
            string name = node->getName();
            emit picked(name);
            emit picked(scribe);
        } else {
            Node::ParentList parents = parentAsScribe->getParents();
            for (Node::ParentList::iterator it = parents.begin(); it != parents.end(); ++it) {
                (*it)->replaceChild(parentAsScribe, node);
            }
            emit unPicked(parentAsScribe);
        }
    }
}

osg::ref_ptr<osg::Node> PickHandler::getHUD()
{
    return hud;
}

osg::ref_ptr<osgText::Text> PickHandler::getText()
{
    return text;
}
