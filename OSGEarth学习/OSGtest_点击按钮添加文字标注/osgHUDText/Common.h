#pragma once

#include <stdio.h>
#include <tchar.h>
#include <SDKDDKVer.h>

#ifdef _DEBUG

#pragma comment(lib, "osgd.lib")
#pragma comment(lib, "osgViewerd.lib")
#pragma comment(lib, "osgDBd.lib")
#pragma comment(lib, "osgUtild.lib")
#pragma comment(lib, "osgGAd.lib")
#pragma comment(lib, "osgFXd.lib")

#pragma comment(lib, "osgSimd.lib")
#pragma comment(lib, "OpenThreadsd.lib")
#pragma comment(lib, "osgAnimationd.lib")
#pragma comment(lib, "osgManipulatord.lib")
#pragma comment(lib, "osgVolumed.lib")
#pragma comment(lib, "osgParticled.lib")
#pragma comment(lib, "osgTextd.lib")

#pragma comment(lib, "osgWidgetd.lib")

#else

#pragma comment(lib, "osg.lib")
#pragma comment(lib, "osgViewer.lib")
#pragma comment(lib, "osgDB.lib")
#pragma comment(lib, "osgUtil.lib")
#pragma comment(lib, "osgGA.lib")
#pragma comment(lib, "osgFX.lib")

#pragma comment(lib, "osgSim.lib")
#pragma comment(lib, "OpenThreads.lib")
#pragma comment(lib, "osgAnimation.lib")
#pragma comment(lib, "osgManipulator.lib")
#pragma comment(lib, "osgVolume.lib")
#pragma comment(lib, "osgParticle.lib")
#pragma comment(lib, "osgText.lib")

#pragma comment(lib, "osgWidget.lib")

#endif

#include <osgViewer/Viewer>
#include <osgDB/ReadFile>
#include <osgWidget/Box>
#include <osgWidget/WindowManager>
#include <osgWidget/ViewerEventHandlers>
#include <osgGA/StateSetManipulator>
#include <osgViewer/ViewerEventHandlers>