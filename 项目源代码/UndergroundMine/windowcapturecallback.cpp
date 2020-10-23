#include "windowcapturecallback.h"

#include <osgViewer/Viewer>

using namespace osg;

WindowCaptureCallback::WindowCaptureCallback()
{
}

void WindowCaptureCallback::operator()(osg::RenderInfo& renderInfo) const
{
    if (captureOnNextFrame) {
        // Get pixel data and save image into a file
        GraphicsContext* gc = renderInfo.getState()->getGraphicsContext();
        ref_ptr<osg::Image> image = new Image;
        image->readPixels(0, 0, gc->getTraits()->width, gc->getTraits()->height, GL_RGBA, GL_UNSIGNED_BYTE);
        osgDB::writeImageFile(*image, filename);
        captureOnNextFrame = false;
    }
}

void WindowCaptureCallback::setFileName(const std::string& filename)
{
    this->filename = filename;
}

void WindowCaptureCallback::setCaptureOnNextFrame(bool flag)
{
    captureOnNextFrame = flag;
}

void renderSceneToImage(osg::Group *root, const std::string &fileName, int width, int height, osg::Matrix proj, osg::Matrix view)
{
    osgViewer::Viewer viewer;
    viewer.setCameraManipulator(nullptr);

    // Setup main camera
    ref_ptr<Camera> camera = new osg::Camera;
    ref_ptr<GraphicsContext::Traits> traits = new GraphicsContext::Traits;
    traits->width = width;
    traits->height = height;
    traits->alpha = 8;
    traits->pbuffer = true;
    traits->doubleBuffer = true;
    traits->sharedContext = nullptr;
    ref_ptr<GraphicsContext> gc = GraphicsContext::createGraphicsContext(traits.get());

    camera->setGraphicsContext(gc.get());
    camera->setClearColor(osg::Vec4(1.0f, 1.0f, 1.0f, 1.0f));
    camera->setClearMask(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    camera->setProjectionMatrix(proj);
    camera->setViewMatrix(view);
    camera->setAllowEventFocus(false);
    camera->setViewport(0, 0, width, height);
    camera->setDrawBuffer(GL_BACK);
    camera->setReadBuffer(GL_BACK);

    ref_ptr<WindowCaptureCallback> wcc = new WindowCaptureCallback;
    wcc->setFileName(fileName);
    wcc->setCaptureOnNextFrame(true);
    camera->setFinalDrawCallback(wcc);

    viewer.setCamera(camera);

    // Setup scene
    viewer.setSceneData(root);

    viewer.realize();
    viewer.frame();
}
