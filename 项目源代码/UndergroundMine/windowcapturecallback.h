#ifndef WINDOWCAPTURECALLBACK_H
#define WINDOWCAPTURECALLBACK_H

#include <Windows.h>
#include <osg/Camera>
#include <osgDB/WriteFile>
#include <string>

class WindowCaptureCallback : public osg::Camera::DrawCallback
{
public:
    WindowCaptureCallback();

    virtual void operator () (osg::RenderInfo& renderInfo) const;

    void setFileName(const std::string& filename);
    void setCaptureOnNextFrame(bool flag);

private:
    std::string filename = "capture.jpg";
    mutable bool captureOnNextFrame = false;
};

void renderSceneToImage(osg::Group *root, const std::string &fileName, int width, int height, osg::Matrix proj, osg::Matrix view);

#endif // WINDOWCAPTURECALLBACK_H
