#ifndef WANDERHANDLER_H
#define WANDERHANDLER_H

#include <QObject>
#include <Windows.h>
#include <osgGA/GUIEventHandler>

#pragma execution_character_set("utf-8")

class WanderHandler : public QObject, public osgGA::GUIEventHandler
{
    Q_OBJECT
public:
    explicit WanderHandler(QObject *parent = nullptr);

    void setStep(int val);

    int getStep();

    bool handle(const osgGA::GUIEventAdapter &ea, osgGA::GUIActionAdapter &aa);

signals:

public slots:

private:
    osg::Vec3d eye, center, up;
    int step = 1.0;
};

#endif // WANDERHANDLER_H
