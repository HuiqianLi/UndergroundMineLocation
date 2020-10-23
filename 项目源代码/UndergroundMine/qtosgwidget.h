#ifndef QTOSGWIDGET_H
#define QTOSGWIDGET_H

#include <QOpenGLWidget>
#include <Windows.h>
#include <osg/Camera>
#include <osg/ShapeDrawable>
#include <osg/StateSet>
#include <osg/Material>
#include <osgViewer/GraphicsWindow>
#include <osgViewer/Viewer>
#include <osgGA/EventQueue>
#include <osgGA/TrackballManipulator>

#pragma execution_character_set("utf-8")

class QtOSGWidget : public QOpenGLWidget
{
    Q_OBJECT
public:
    QtOSGWidget(QWidget* parent = nullptr);

    virtual ~QtOSGWidget(){}

    osg::ref_ptr<osgViewer::Viewer> getViewer();

signals:
    void trackballRotated(osg::Quat q);

public slots:
    void rotateTrackball(osg::Quat q);

protected:
    virtual void paintGL();

    virtual void resizeGL(int width, int height);

    // set up any required OpenGL resources and state.
    virtual void initializeGL();

    // override event handlers
    virtual void mouseMoveEvent(QMouseEvent* event);
    virtual void mousePressEvent(QMouseEvent* event);
    virtual void mouseReleaseEvent(QMouseEvent* event);
    virtual void wheelEvent(QWheelEvent* event);
    virtual void keyPressEvent(QKeyEvent* event);
    virtual void keyReleaseEvent(QKeyEvent* event);
    virtual int keyMap(QKeyEvent* event);
    virtual bool event(QEvent* event);

private:
    osgGA::EventQueue* getEventQueue() const;
    osg::ref_ptr<osgViewer::GraphicsWindowEmbedded> m_graphicsWindow;
    osg::ref_ptr<osgViewer::Viewer> m_viewer;
    osg::Quat m_rotate;
    osgGA::TrackballManipulator* m_manipulator;
};

#endif // QTOSGWIDGET_H
