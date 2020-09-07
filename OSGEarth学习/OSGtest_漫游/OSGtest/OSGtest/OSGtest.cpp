#include "stdafx.h"
#include <osgViewer/Viewer>

#include <osg/Node>
#include <osg/Geode>
#include <osg/Group>

#include <osgDB/ReadFile>
#include <osgDB/WriteFile>

#include <osgUtil/Optimizer>

#include "ManipulatorTravel.h"

int main()
{
//创建Viewer对象，场景浏览器
osgViewer::Viewer* viewer = new osgViewer::Viewer();

//把漫游器加入到场景中
TravelManipulator::TravelToScene(viewer);

osg::Group* root = new osg::Group();

//读取地形模型
osg::Node* node = new osg::Node();
node = osgDB::readNodeFile("C:/Users/Chinesesman/Desktop/test4.ive");

//添加到场景
root->addChild(node);

//优化场景数据
osgUtil::Optimizer optimizer ;
optimizer.optimize(root) ;

viewer->setSceneData(root);

viewer->realize();

viewer->run();

return 0 ;
}