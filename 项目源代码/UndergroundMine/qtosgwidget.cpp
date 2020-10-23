#include "qtosgwidget.h"

#include <QMouseEvent>
#include <QWheelEvent>
#include <QDebug>

QtOSGWidget::QtOSGWidget(QWidget* parent)
    : QOpenGLWidget(parent)
    , m_graphicsWindow(new osgViewer::GraphicsWindowEmbedded(this->x(), this->y(), this->width(), this->height()))
    , m_viewer(new osgViewer::Viewer)
{
    // configure camera
    osg::Camera* camera = new osg::Camera;
    camera->setViewport(0, 0, this->width(), this->height());
    camera->setClearColor(osg::Vec4( 0, 0, 0.3f, 1.f ));
    double aspectRatio = static_cast<double>(this->width()) / static_cast<double>(this->height());
    camera->setProjectionMatrixAsPerspective(30.0, aspectRatio, 1.0, 1000.0);
    camera->setGraphicsContext(m_graphicsWindow);

    // use TrackballManipulator as default manipulator
    m_manipulator = new osgGA::TrackballManipulator;
    m_manipulator->setAllowThrow(false);

    // init and realize osgViewer
    m_viewer->setCamera(camera);
    m_viewer->setCameraManipulator(m_manipulator);
    m_viewer->setThreadingModel(osgViewer::Viewer::SingleThreaded);

    m_viewer->realize();

    m_rotate = m_manipulator->getRotation();

    // ensure widget receive all keyboard and mouse events
    this->setFocusPolicy(Qt::StrongFocus);
    this->setMouseTracking(true);
}

void QtOSGWidget::paintGL()
{
    m_viewer->frame();
}

void QtOSGWidget::resizeGL(int width, int height)
{
    this->getEventQueue()->windowResize(this->x(), this->y(), width, height);
    m_graphicsWindow->resized(this->x(), this->y(), width, height);
    osg::Camera* camera = m_viewer->getCamera();
    camera->setViewport(0, 0, this->width(), this->height());
}

void QtOSGWidget::initializeGL()
{
    osg::StateSet* stateSet = m_viewer->getCamera()->getOrCreateStateSet();
    osg::Material* material = new osg::Material;
    material->setColorMode(osg::Material::AMBIENT_AND_DIFFUSE);
    stateSet->setAttributeAndModes(material, osg::StateAttribute::ON);
    stateSet->setMode(GL_DEPTH_TEST, osg::StateAttribute::ON);
}

void QtOSGWidget::mouseMoveEvent(QMouseEvent *event)
{
    this->getEventQueue()->mouseMotion(event->x(), event->y());
}

void QtOSGWidget::mousePressEvent(QMouseEvent *event)
{
    unsigned int button = 0;
    switch (event->button()){
    case Qt::LeftButton:
        button = 1;
        break;
    case Qt::MiddleButton:
        button = 2;
        break;
    case Qt::RightButton:
        button = 3;
        break;
    default:
        break;
    }
    this->getEventQueue()->mouseButtonPress(event->x(), event->y(), button);
}

void QtOSGWidget::mouseReleaseEvent(QMouseEvent *event)
{
    unsigned int button = 0;
    switch (event->button()){
    case Qt::LeftButton:
        button = 1;
        break;
    case Qt::MiddleButton:
        button = 2;
        break;
    case Qt::RightButton:
        button = 3;
        break;
    default:
        break;
    }
    this->getEventQueue()->mouseButtonRelease(event->x(), event->y(), button);
}

void QtOSGWidget::wheelEvent(QWheelEvent *event)
{
    int delta = event->delta();
    osgGA::GUIEventAdapter::ScrollingMotion motion = delta > 0 ?
                osgGA::GUIEventAdapter::SCROLL_UP : osgGA::GUIEventAdapter::SCROLL_DOWN;
    this->getEventQueue()->mouseScroll(motion);
}

void QtOSGWidget::keyPressEvent(QKeyEvent *event)
{
    this->getEventQueue()->keyPress(keyMap(event));
}

void QtOSGWidget::keyReleaseEvent(QKeyEvent *event)
{
    this->getEventQueue()->keyRelease(keyMap(event));
}

int QtOSGWidget::keyMap(QKeyEvent *e) {
    int key = 0;
    switch (e->key()) {
    case Qt::Key_Up:
    {
        key = osgGA::GUIEventAdapter::KEY_Up;
        break;
    }
    case Qt::Key_Down:
    {
        key = osgGA::GUIEventAdapter::KEY_Down;
        break;
    }
    case Qt::Key_Left:
    {
        key = osgGA::GUIEventAdapter::KEY_Left;
        break;
    }
    case Qt::Key_Right:
    {
        key = osgGA::GUIEventAdapter::KEY_Right;
        break;
    }
    case Qt::Key_Home:
    {
        key = osgGA::GUIEventAdapter::KEY_Home;
        break;
    }
    case Qt::Key_End:
    {
        key = osgGA::GUIEventAdapter::KEY_End;
        break;
    }
    default:
    {
        QByteArray keyBytes = e->text().toLatin1();
        const char *keyData = keyBytes.data();
        key = osgGA::GUIEventAdapter::KeySymbol(*keyData);
    }
    }

    return key;
}

bool QtOSGWidget::event(QEvent *event)
{
    // ensure that repaints happen after user interactions
    bool handled = QOpenGLWidget::event(event);
    if (m_rotate != m_manipulator->getRotation()) {
        m_rotate = m_manipulator->getRotation();
        emit trackballRotated(m_rotate);
    }
    this->update();
    return handled;
}

osgGA::EventQueue* QtOSGWidget::getEventQueue() const
{
    return m_graphicsWindow->getEventQueue();
}

osg::ref_ptr<osgViewer::Viewer> QtOSGWidget::getViewer()
{
    return m_viewer;
}

void QtOSGWidget::rotateTrackball(osg::Quat q)
{
    m_manipulator->setRotation(q);
}
