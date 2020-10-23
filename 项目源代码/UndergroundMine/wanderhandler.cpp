#include "wanderhandler.h"

#include <osgViewer/Viewer>
#include <osgGA/TrackballManipulator>

//#include <QDebug>

using namespace osg;
using namespace osgGA;

WanderHandler::WanderHandler(QObject *parent) : QObject(parent)
{

}

bool WanderHandler::handle(const osgGA::GUIEventAdapter &ea, osgGA::GUIActionAdapter &aa)
{
    ref_ptr<osgViewer::Viewer> viewer = dynamic_cast<osgViewer::Viewer*>(&aa);
    if (!viewer) {
        return false;
    }

    switch (ea.getEventType()) {
    case osgGA::GUIEventAdapter::KEYDOWN:
    {
        ref_ptr<TrackballManipulator> m = dynamic_cast<TrackballManipulator*>(viewer->getCameraManipulator());
        if (m) {
            m->getTransformation(eye, center, up);
            Vec3d front = center - eye;
            Vec3d right = front ^ up;
            up.normalize();
            front.normalize();
            right.normalize();
            Vec3d t;
//            double step = m->getDistance()*0.1;
            if (ea.getKey() == GUIEventAdapter::KEY_Up) {
                t = up * step;
            } else if (ea.getKey() == GUIEventAdapter::KEY_Down) {
                t = -up * step;
            } else if (ea.getKey() == GUIEventAdapter::KEY_Left) {
                t = -right * step;
            } else if (ea.getKey() == GUIEventAdapter::KEY_Right) {
                t = right * step;
            } else if (ea.getKey() == GUIEventAdapter::KEY_Home) {
                t = front * step;
            } else if (ea.getKey() == GUIEventAdapter::KEY_End){
                t = - front * step;
            }
            m->setCenter(center + t);
            m->setTransformation(eye + t, center + t, up);
        }
        break;
    }
    default:
    {
        break;
    }
    }

    return false;
}

void WanderHandler::setStep(int val)
{
    step = val;
}


int WanderHandler::getStep()
{
    return step;
}
