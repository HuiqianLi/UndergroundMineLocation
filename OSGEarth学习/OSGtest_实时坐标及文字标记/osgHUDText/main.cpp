#include <iostream>

#include "ManipulatorTravel.h"
#include "AddWords.h"
#include "Common.h"
#include "HUDtext.h"

int main(int argc, char **argv)
{
//加入HUD坐标文字
osgText::Text* pos_text = new osgText::Text;
osg::ref_ptr< CHUD_viewPoint> pHUD = new CHUD_viewPoint(pos_text);

setlocale(LC_ALL,".936");//　配置地域化信息
const char* textString={
        "人生若只如初见，何事秋风悲画扇；\n"
        "等闲变却故人心，却道故人心易变；\n"
        "骊山语罢倾销半，夜雨霖铃终不怨；\n"
        "何如薄幸锦衣郎，比翼连枝当日愿。"
    };
osgText::Font* fontKai=osgText::readFontFile("C:\\WINDOWS\\Fonts\\simkai.ttf");

//设置y坐标控制前后,-后面值越小越靠前
osg::ref_ptr<osgText::Text> text=new osgText::Text;
//获取视角所在的坐标
//setupProperties(*text,fontKai,100.0,pHUD->GetM_VPosEye());
setupProperties(*text,fontKai,100.0,osg::Vec3(0.0f, -40000.0f, -25000.0f));
createContent(*text,textString);

osg::ref_ptr<osg::Geode> geode=new osg::Geode;
geode->addDrawable(text.get());

//创建Viewer对象，场景浏览器
osgViewer::Viewer* viewer = new osgViewer::Viewer();

//HUD显示位置
viewer->setUpViewInWindow(100, 100, 1080, 960);

//把漫游器加入到场景中
TravelManipulator::TravelToScene(viewer);

osg::Group* root = new osg::Group();

//读取地形模型
osg::Node* node = new osg::Node();
node = osgDB::readNodeFile("C:/Users/Chinesesman/Desktop/test4.ive");
//node = osgDB::readNodeFile("cow.osg");

//上面node可以加载多个,然后root->add后面加上就可以了
//将模型添加到场景
root->addChild(node);
root->addChild(geode.get());//标记
root->addChild(createHUD_viewPoint(pos_text));//加入HUD坐标文字

//优化场景数据
osgUtil::Optimizer optimizer ;
optimizer.optimize(root) ;
viewer->addEventHandler(pHUD.get());//HUD坐标
viewer->setSceneData(root);
viewer->realize();
viewer->run();
return 0;

}
