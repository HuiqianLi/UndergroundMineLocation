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
//����Viewer���󣬳��������
osgViewer::Viewer* viewer = new osgViewer::Viewer();

//�����������뵽������
TravelManipulator::TravelToScene(viewer);

osg::Group* root = new osg::Group();

//��ȡ����ģ��
osg::Node* node = new osg::Node();
node = osgDB::readNodeFile("C:/Users/Chinesesman/Desktop/test4.ive");

//��ӵ�����
root->addChild(node);

//�Ż���������
osgUtil::Optimizer optimizer ;
optimizer.optimize(root) ;

viewer->setSceneData(root);

viewer->realize();

viewer->run();

return 0 ;
}