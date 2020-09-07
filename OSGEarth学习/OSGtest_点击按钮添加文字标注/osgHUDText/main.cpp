#include <iostream>

#include "Common.h"

#include "ManipulatorTravel.h"
#include "AddWords.h"
#include "HUDPos.h"

//Ϊ�˷��㣬���Խ���ģ�ͣ����ڵײ���Ҫ���ı�������Ϊȫ�ֱ���
osgWidget::Label* label = new osgWidget::Label("");
//��ȡ����ģ��
osg::Node* node = osgDB::readNodeFile("C:/Users/Chinesesman/Desktop/test4.ive");
//����HUD��������
osgText::Text* pos_text = new osgText::Text;
osg::ref_ptr< CHUD_viewPoint> pHUD = new CHUD_viewPoint(pos_text);
//���ֱ��
osg::ref_ptr<osg::Geode> geode=new osg::Geode;

//��osgWidget::Widget���������������Ҳ���ǰ�ť����
class ColorWidget : public osgWidget::Widget
{
public://��ť��СΪ96��96
    ColorWidget() : osgWidget::Widget("", 96, 96)
    {
        //���������¼�
        setEventMask(osgWidget::EVENT_ALL);
    }

	bool mousePush(double, double, const osgWidget::WindowManager* wm)
    {
        //��������cow.osg��ť���������õ����֣�
        if(getName() == "HUDtext")
        {
            //�󾮵�ģ����ʾ�����أ����صĻ�����ʾ
            //node->setNodeMask(! node->getNodeMask());
			
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
			setupProperties(*text,fontKai,100.0,pHUD->GetM_VPosEye());
			//���ù̶�ֵ����
			//setupProperties(*text,fontKai,100.0,osg::Vec3(0.0f, -40000.0f, -25000.0f));
			createContent(*text,textString);

			geode->addDrawable(text.get());
			
        }
        //��������ʾһ����ɫ������������ʾ��ͷ��ɫ��
        setColor(1.0, 1.0, 1.0, 1.0);
        return true;
    }

    bool mouseRelease(double, double, const osgWidget::WindowManager*)
    {
        //͸���Ȼ�ԭ��0.8
        setColor(1.0, 1.0, 1.0, 0.8);
        return true;
    }

    bool mouseEnter(double, double, const osgWidget::WindowManager*)
    {
        if(getName() == "HUDtext")
        {
            //����ڰ�ť�Ϸ�ʱ���ı�label�����ݺͰ�ť��ɫ
            label->setLabel("Add HUDtext");
        }
        setColor(0.7, 0.7, 1.0, 0.8);
        return true;
    }

    bool mouseLeave(double, double, const osgWidget::WindowManager*)
    {
        //����Ƴ���ť��ɫ�ı䣬label�������
        label->setLabel(L"|- - - - - - - - - - - - - - - - -  ");
        setColor(1.0, 1.0, 1.0, 0.5);
        return true;
    }
};


//����������д�����1����ť
osgWidget::Box* createBox(const std::string& name, osgWidget::Box::BoxType bt)
{
    osgWidget::Box* box = new osgWidget::Box(name, bt);
    osgWidget::Widget* widget = new ColorWidget();
    //���ð�ťλ��
    box->setOrigin(704, 108);
    //�鱾ʹ�õ���pngͼƬ����Ϊû��ʹ��png���������ʹ��jpg�ļ���
    //widget->setImage("Images/star.jpg");
    widget->setName("HUDtext");
    //����ť����ͼ������Ĳ�������
    //widget->setTexCoord(0.0, 0.0, osgWidget::Widget::LOWER_LEFT);
    //widget->setTexCoord(1.0, 0.0, osgWidget::Widget::LOWER_RIGHT);
    //widget->setTexCoord(1.0, 1.0, osgWidget::Widget::UPPER_RIGHT);
    //widget->setTexCoord(0.0, 1.0, osgWidget::Widget::UPPER_LEFT);
    //���ð�ť��ɫ
    widget->setColor(1.0, 1.0, 1.0, 0.5);
    box->addWidget(widget);

    return box;
}

int main(int argc, char **argv)
{
osg::ref_ptr<osgViewer::Viewer> viewer = new osgViewer::Viewer;
    osgWidget::WindowManager* wm = new osgWidget::WindowManager
    (
        viewer.get(),
        800,
        600,
        1,
        osgWidget::WindowManager::WM_USE_RENDERBINS
    );

    osgWidget::Window* box = createBox("Box", osgWidget::Box::VERTICAL);
    box->getBackground()->setColor(1.0, 1.0, 1.0, 0.0);
    box->attachMoveCallback();
    wm->addChild(box);

    //��ӱ�ǩ��ʵʱ��ʾ������Ϣ
    osgWidget::Box* labelBox = new osgWidget::Box("LabelBox", osgWidget::Box::VERTICAL);
    label->setFont("fonts/Vers.TTF");
    label->setFontSize(14);
    label->setFontColor(0.0, 0, 0, 0.5);
    label->setAlignHorizontal(osgWidget::Widget::HA_LEFT);
    label->setPadding(1.0f);
    label->setLabel(L"|- - - - - - - - - - - - - - - - -  ");


    labelBox->addWidget(label);
    labelBox->getBackground()->setColor(1.0, 1.0, 1.0, 0.4);
    labelBox->setOrigin(0, 0);
    wm->addChild(labelBox);

	//HUD��ʾλ��
	viewer->setUpViewInWindow(100, 100, 1080, 960);

	//�����������뵽������
	TravelManipulator::TravelToScene(viewer);

    osg::Group* root = new osg::Group;
    root->addChild(node);
	root->addChild(geode.get());//���
	root->addChild(createHUD_viewPoint(pos_text));//����HUD��������

	//osgUtil::Optimizer optimizer ;
	//optimizer.optimize(root) ;
	viewer->addEventHandler(pHUD.get());//HUD����
	//viewer->setSceneData(root);
	//viewer->realize();
	//viewer->run();
    return osgWidget::createExample(* viewer, wm, root);

}
