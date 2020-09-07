#include <iostream>

#include "ManipulatorTravel.h"
#include "AddWords.h"
#include "Common.h"
#include "HUDtext.h"

int main(int argc, char **argv)
{
//����HUD��������
osgText::Text* pos_text = new osgText::Text;
osg::ref_ptr< CHUD_viewPoint> pHUD = new CHUD_viewPoint(pos_text);

setlocale(LC_ALL,".936");//�����õ�����Ϣ
const char* textString={
        "������ֻ�������������籯���ȣ�\n"
        "���б�ȴ�����ģ�ȴ���������ױ䣻\n"
        "��ɽ��������룬ҹ�������ղ�Թ��\n"
        "���籡�ҽ����ɣ�������֦����Ը��"
    };
osgText::Font* fontKai=osgText::readFontFile("C:\\WINDOWS\\Fonts\\simkai.ttf");

//����y�������ǰ��,-����ֵԽСԽ��ǰ
osg::ref_ptr<osgText::Text> text=new osgText::Text;
//��ȡ�ӽ����ڵ�����
//setupProperties(*text,fontKai,100.0,pHUD->GetM_VPosEye());
setupProperties(*text,fontKai,100.0,osg::Vec3(0.0f, -40000.0f, -25000.0f));
createContent(*text,textString);

osg::ref_ptr<osg::Geode> geode=new osg::Geode;
geode->addDrawable(text.get());

//����Viewer���󣬳��������
osgViewer::Viewer* viewer = new osgViewer::Viewer();

//HUD��ʾλ��
viewer->setUpViewInWindow(100, 100, 1080, 960);

//�����������뵽������
TravelManipulator::TravelToScene(viewer);

osg::Group* root = new osg::Group();

//��ȡ����ģ��
osg::Node* node = new osg::Node();
node = osgDB::readNodeFile("C:/Users/Chinesesman/Desktop/test4.ive");
//node = osgDB::readNodeFile("cow.osg");

//����node���Լ��ض��,Ȼ��root->add������ϾͿ�����
//��ģ����ӵ�����
root->addChild(node);
root->addChild(geode.get());//���
root->addChild(createHUD_viewPoint(pos_text));//����HUD��������

//�Ż���������
osgUtil::Optimizer optimizer ;
optimizer.optimize(root) ;
viewer->addEventHandler(pHUD.get());//HUD����
viewer->setSceneData(root);
viewer->realize();
viewer->run();
return 0;

}
