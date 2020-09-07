# 一、OSGEarth的编译

参考教程：https://blog.csdn.net/wangbingqian_110/article/details/78069061

```c++
#include "stdafx.h"
#include<osgViewer/Viewer>
#include<osgDB/ReadFile>

int main(int argc, char **argv)
{
    osgViewer::Viewer viewer;
    viewer.setSceneData(osgDB::readNodeFile("cow.osg"));
    return viewer.run();
}
```

# 二、 位置变换节点

 osg::PositionAttitudeTransform 

参考教程：https://www.qxqzx.com/contents/234.html

```c++
#include "stdafx.h"
#include <osgViewer/Viewer>
 
#include <osg/Node>
#include <osg/Geode>
#include <osg/Group>
#include <osg/PositionAttitudeTransform>
 
#include <osgDB/ReadFile>
#include <osgDB/WriteFile>
 
#include <osgUtil/Optimizer>

osg::ref_ptr<osg::Node> CreateNode()
{
	osg::ref_ptr<osg::Group> _root = new osg::Group;
 
	//创建一个节点，读取牛的模型
	osg::ref_ptr<osg::Node> node = osgDB::readNodeFile("cow.osg");
 
	//创建位置变换节点pat1,缩放
	osg::ref_ptr<osg::PositionAttitudeTransform> pat1 = new osg::PositionAttitudeTransform;
	//设置位置为-10，0，0
	pat1->setPosition(osg::Vec3(-10.0f, 0.0f, 0.0f));
	//设置缩放在X,Y,Z都缩小一倍
	pat1->setScale(osg::Vec3(0.5f, 0.5f, 0.5f));
	//把牛放到这个位置变化节点中去
	pat1->addChild(node.get());
	_root->addChild(pat1.get());
 
	//创建位置变换节点pat2，平移位置
	osg::ref_ptr<osg::PositionAttitudeTransform> pat2 = new osg::PositionAttitudeTransform;
	//设置位置为10，0，0
	pat2->setPosition(osg::Vec3(10.0f,0.0f,0.0f));
	pat2->addChild(node.get());
	_root->addChild(pat2.get());
 
	//创建位置变换节点pat3，改变姿态
	osg::ref_ptr<osg::PositionAttitudeTransform> pat3 = new osg::PositionAttitudeTransform;
	//设置位置为10，0，0
	pat3->setPosition(osg::Vec3(0.0f, 0.0f, 0.0f));
	//姿态变化,绕着osg::Vec3(0.0f,1.0f,0.0f)把物体旋转osg::PI个弧度
	pat3->setAttitude(osg::Quat(osg::PI, osg::Vec3(0.0f, 1.0f, 0.0f)));
	pat3->addChild(node.get());
	_root->addChild(pat3.get());
 
	return _root.get();
}
 
int main()
{
	//创建Viewer对象，场景浏览器
	osg::ref_ptr<osgViewer::Viewer> viewer = new osgViewer::Viewer();
 
	osg::ref_ptr<osg::Group> root = new osg::Group();
 
	//添加到场景
	root->addChild(CreateNode());
 
	//优化场景数据
	osgUtil::Optimizer optimizer;
	optimizer.optimize(root.get());
 
	// set the scene to render
	viewer->setSceneData(root.get());
 
	viewer->realize();
 
	viewer->run();
 
	return 0;
}

```

# 三、矩阵变换节点

 osg::MatrixTransform 

参考教程：https://www.qxqzx.com/contents/272.html

```c++
#include "stdafx.h"
#include <osgViewer/Viewer>
 
#include <osg/Node>
#include <osg/Geode>
#include <osg/Group>
#include <osg/PositionAttitudeTransform>
#include <osg/MatrixTransform>
 
#include <osgDB/ReadFile>
#include <osgDB/WriteFile>
 
#include <osgUtil/Optimizer>

osg::ref_ptr<osg::Node> CreateNode()
{
	osg::ref_ptr<osg::Group> _root = new osg::Group;
 
	//依然创建节点，咱继续把牛弄进来玩
	osg::ref_ptr<osg::Node> _node = osgDB::readNodeFile("cow.osg");
 
	//构造一个变换矩阵节点
	osg::ref_ptr<osg::MatrixTransform> _mt = new osg::MatrixTransform;
	//创建一个矩阵对象,下面这个经过实践，只能保持最后一次的效果，也就是说先平移，再旋转的话，只能保留旋转而不能平移
	osg::Matrix _m;
	_m.makeTranslate(osg::Vec3(10.0f,0.0f,0.0f));//X方向平移10个单位
	_m.makeRotate(45.0f, osg::Vec3(1.0f,0.0f,0.0f));//绕着后面这个轴转45度
	_mt->setMatrix(_m);
	_mt->addChild(_node.get());
 
	//构造一个变换矩阵节点
	osg::ref_ptr<osg::MatrixTransform> _mt1 = new osg::MatrixTransform;
	//创建一个矩阵对象
	//要达到叠加效果，需要矩阵相乘，一下两种方式可以得到
//	osg::Matrix _m1 = osg::Matrix::translate(osg::Vec3(-10.0f, 0.0f, 0.0f))
//		*osg::Matrix::rotate(-45.0f, osg::Vec3(1.0f, 0.0f, 0.0f));//X方向平移-10个单位//_m1.makeRotate();//绕着后面这个轴转45度
	osg::Matrix _m1,_m2;
	_m1.makeTranslate(osg::Vec3(-10.0f, 0.0f, 0.0f));//X方向平移10个单位
	_m2.makeRotate(-45.0f, osg::Vec3(1.0f, 0.0f, 0.0f));//绕着后面这个轴转-45度
	_m1 = _m1*_m2;
	_mt1->setMatrix(_m1);
	_mt1->addChild(_node.get());
 
	_root->addChild(_mt.get());
	_root->addChild(_mt1.get());
	_root->addChild(_node.get());//增加未变换的点，用来对比一下
 
	return _root.get();
}
 
int main()
{
	//创建Viewer对象，场景浏览器
	osg::ref_ptr<osgViewer::Viewer> viewer = new osgViewer::Viewer();
 
	osg::ref_ptr<osg::Group> root = new osg::Group();
 
	//添加到场景
	root->addChild(CreateNode());
 
	//优化场景数据
	osgUtil::Optimizer optimizer;
	optimizer.optimize(root.get());
 
	// set the scene to render
	viewer->setSceneData(root.get());
 
	viewer->realize();
 
	viewer->run();
 
	return 0;
}
```

# 四、自动对齐节点

……

# 八、几何体的绘制

参考教程：https://www.qxqzx.com/contents/303.html

参考源码：https://blog.csdn.net/thanklife/article/details/52861690

以下代码效果为绘制一个四边形。

```c++
#include "stdafx.h"
#include <osgViewer/Viewer>
 
#include <osg/Node>
#include <osg/Geode>
#include <osg/Group>
 
#include <osgDB/ReadFile>
#include <osgDB/WriteFile>
 
#include <osgUtil/Optimizer>

osg::ref_ptr<osg::Node> createQuad()
{
	//创建一个叶节点对象
	osg::ref_ptr<osg::Geode> geode = new osg::Geode();
	//创建一个几何体对象
	osg::ref_ptr<osg::Geometry> geom = new osg::Geometry();
	
	//创建顶点数组
	osg::ref_ptr<osg::Vec3Array> v = new osg::Vec3Array();
	//逆时针添加数据
	v->push_back(osg::Vec3(0.0f, 0.0f, 0.0f));
	v->push_back(osg::Vec3(1.0f, 0.0f, 0.0f));
	v->push_back(osg::Vec3(1.0f, 0.0f, 1.0f));
	v->push_back(osg::Vec3(0.0f, 0.0f, 1.0f));
	//设置顶点数据
	geom->setVertexArray(v.get());
	
	
	osg::ref_ptr<osg::Vec2Array> vt = new osg::Vec2Array();
	vt->push_back(osg::Vec2(0.0f, 0.0f));
	vt->push_back(osg::Vec2(1.0f, 0.0f));
	vt->push_back(osg::Vec2(1.0f, 1.0f));
	vt->push_back(osg::Vec2(0.0f, 1.0f));
	
	geom->setTexCoordArray(0, vt.get());
 
	//创建颜色数组
	osg::ref_ptr<osg::Vec4Array> vc = new osg::Vec4Array();
	vc->push_back(osg::Vec4(1.0f, 0.0f, 0.0f, 1.0f));
	vc->push_back(osg::Vec4(0.0f, 1.0f, 0.0f, 1.0f));
	vc->push_back(osg::Vec4(0.0f, 0.0f, 1.0f, 1.0f));
	vc->push_back(osg::Vec4(1.0f, 1.0f, 0.0f, 1.0f));
	//设置颜色数组
	geom->setColorArray(vc.get());
	//设置颜色绑定模式
	geom->setColorBinding(osg::Geometry::BIND_PER_VERTEX);
 
	//创建法线数组
	osg::ref_ptr<osg::Vec3Array> nc = new osg::Vec3Array();
	//增加法线,几何体顶点都是是在XOZ面上，所以法线是Y轴
	nc->push_back(osg::Vec3(0.0f, -1.0f, 0.0f));
 
	//设置法线数组
	geom->setNormalArray(nc.get());
	geom->setNormalBinding(osg::Geometry::BIND_OVERALL);
 
	//添加图元，绘图基元为四边形，从第0个元素开始的四个元素，按照QUADS方式绘制四边形
	geom->addPrimitiveSet(new osg::DrawArrays(osg::PrimitiveSet::QUADS, 0, 4));
 
	//添加到叶子节点中
	geode->addDrawable(geom.get());
	return geode.get();
}
 
int main()
{
	//创建Viewer对象，场景浏览器
	osg::ref_ptr<osgViewer::Viewer> viewer = new osgViewer::Viewer();
 
	osg::ref_ptr<osg::Group> root = new osg::Group();
 
	//添加到场景
	root->addChild(createQuad());
 
	//优化场景数据
	osgUtil::Optimizer optimizer;
	optimizer.optimize(root.get());
 
	// set the scene to render
	viewer->setSceneData(root.get());
 
	viewer->realize();
 
	viewer->run();
 
	return 0;
}
```

以下代码按照索引组织绘制数据 。（一个三角形，一个四边形）

```c++
#include "stdafx.h"
#include <osgViewer/Viewer>
 
#include <osg/Node>
#include <osg/Geode>
#include <osg/Group>
 
#include <osgDB/ReadFile>
#include <osgDB/WriteFile>
 
#include <osgUtil/Optimizer>

//绘制基本四边形
osg::ref_ptr<osg::Node> CreateNode()
{
	osg::ref_ptr<osg::Group> _root = new osg::Group;
 
	//创建一个叶结点对象
	osg::ref_ptr<osg::Geode> geode = new osg::Geode;
	//创建一个几何体对象
	osg::ref_ptr<osg::Geometry> geom = new osg::Geometry;
 
	//创建顶点数组，逆时针顺序
	osg::ref_ptr<osg::Vec3Array> v = new osg::Vec3Array;
	//逆时针添加数据
	v->push_back(osg::Vec3(0.0f, 0.0f, 0.0f));
	v->push_back(osg::Vec3(1.0f, 0.0f, 0.0f));
	v->push_back(osg::Vec3(1.0f, 0.0f, 1.0f));
	v->push_back(osg::Vec3(0.0f, 0.0f, 1.0f));
	v->push_back(osg::Vec3(0.0f, -1.0f, 0.0f));
	//设置顶点数据
	geom->setVertexArray(v);
 
	//创建四边形顶点索引数组，指定绘图基元为四边形
	osg::ref_ptr<osg::DrawElementsUInt> quad = new osg::DrawElementsUInt(osg::PrimitiveSet::QUADS, 0);
	//添加四边形的索引数据
	quad->push_back(0);
	quad->push_back(1);
	quad->push_back(2);
	quad->push_back(3);
	//添加到几何体
	geom->addPrimitiveSet(quad);
 
	//创建三角形顶点索引数据，制定绘图基元为三角形
	osg::ref_ptr<osg::DrawElementsUInt> tri = new osg::DrawElementsUInt(osg::PrimitiveSet::TRIANGLES, 0);
	//添加数据
	tri->push_back(4);
	tri->push_back(0);
	tri->push_back(3);
	//添加到几何体
	geom->addPrimitiveSet(tri);
 
	//创建颜色数组
	osg::ref_ptr<osg::Vec4Array> vc = new osg::Vec4Array;
	vc->push_back(osg::Vec4(1.0f, 0.0f, 0.0f, 1.0f));
	vc->push_back(osg::Vec4(0.0f, 1.0f, 0.0f, 1.0f));
	vc->push_back(osg::Vec4(0.0f, 0.0f, 1.0f, 1.0f));
	vc->push_back(osg::Vec4(1.0f, 1.0f, 0.0f, 1.0f));
	vc->push_back(osg::Vec4(0.0f, 0.0f, 1.0f, 1.0f));
 
	//设置颜色数组
	geom->setColorArray(vc);
	//设置颜色绑定模式
	geom->setColorBinding(osg::Geometry::BIND_PER_VERTEX);
 
	//创建法线数组
	osg::ref_ptr<osg::Vec3Array> nc = new osg::Vec3Array;
	//增加法线,几何体顶点都是是在XOZ面上，所以法线是Y轴
	nc->push_back(osg::Vec3(0.0f, -1.0f, 0.0f));
	//设置法线
	geom->setNormalArray(nc);
	//设置法线的绑定方式为全部节点
	geom->setNormalBinding(osg::Geometry::BIND_OVERALL);
 
	//添加到叶子节点中
	geode->addChild(geom);
	_root->addChild(geode);
 
	return _root.get();
}
 
int main()
{
	//创建Viewer对象，场景浏览器
	osg::ref_ptr<osgViewer::Viewer> viewer = new osgViewer::Viewer();
 
	osg::ref_ptr<osg::Group> root = new osg::Group();
 
	//添加到场景
	root->addChild(CreateNode());
 
	//优化场景数据
	osgUtil::Optimizer optimizer;
	optimizer.optimize(root.get());
 
	// set the scene to render
	viewer->setSceneData(root.get());
 
	viewer->realize();
 
	viewer->run();
 
	return 0;
}
```

# 