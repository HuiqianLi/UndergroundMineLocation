#include <iostream>

#include "Common.h"

#include "ManipulatorTravel.h"
#include "AddWords.h"
#include "HUDPos.h"

//为了方便，将自建矿井模型，窗口底层需要的文本框设置为全局变量
osgWidget::Label* label = new osgWidget::Label("");
//读取地形模型
osg::Node* node = osgDB::readNodeFile("C:/Users/Chinesesman/Desktop/test4.ive");
//加入HUD坐标文字
osgText::Text* pos_text = new osgText::Text;
osg::ref_ptr< CHUD_viewPoint> pHUD = new CHUD_viewPoint(pos_text);
//文字标记
osg::ref_ptr<osg::Geode> geode=new osg::Geode;

//从osgWidget::Widget派生窗口类变量，也就是按钮窗口
class ColorWidget : public osgWidget::Widget
{
public://按钮大小为96×96
    ColorWidget() : osgWidget::Widget("", 96, 96)
    {
        //接收所有事件
        setEventMask(osgWidget::EVENT_ALL);
    }

	bool mousePush(double, double, const osgWidget::WindowManager* wm)
    {
        //如果点击了cow.osg按钮（程序设置的名字）
        if(getName() == "HUDtext")
        {
            //矿井的模型显示就隐藏，隐藏的话就显示
            //node->setNodeMask(! node->getNodeMask());
			
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
			setupProperties(*text,fontKai,100.0,pHUD->GetM_VPosEye());
			//设置固定值坐标
			//setupProperties(*text,fontKai,100.0,osg::Vec3(0.0f, -40000.0f, -25000.0f));
			createContent(*text,textString);

			geode->addDrawable(text.get());
			
        }
        //单击了显示一种颜色，其他操作显示不头颜色。
        setColor(1.0, 1.0, 1.0, 1.0);
        return true;
    }

    bool mouseRelease(double, double, const osgWidget::WindowManager*)
    {
        //透明度还原到0.8
        setColor(1.0, 1.0, 1.0, 0.8);
        return true;
    }

    bool mouseEnter(double, double, const osgWidget::WindowManager*)
    {
        if(getName() == "HUDtext")
        {
            //鼠标在按钮上方时，改变label的内容和按钮颜色
            label->setLabel("Add HUDtext");
        }
        setColor(0.7, 0.7, 1.0, 0.8);
        return true;
    }

    bool mouseLeave(double, double, const osgWidget::WindowManager*)
    {
        //鼠标移出按钮颜色改变，label内容清空
        label->setLabel(L"|- - - - - - - - - - - - - - - - -  ");
        setColor(1.0, 1.0, 1.0, 0.5);
        return true;
    }
};


//在这个函数中创建了1个按钮
osgWidget::Box* createBox(const std::string& name, osgWidget::Box::BoxType bt)
{
    osgWidget::Box* box = new osgWidget::Box(name, bt);
    osgWidget::Widget* widget = new ColorWidget();
    //设置按钮位置
    box->setOrigin(704, 108);
    //书本使用的是png图片，因为没有使用png插件，这里使用jpg文件。
    //widget->setImage("Images/star.jpg");
    widget->setName("HUDtext");
    //往按钮上贴图和纹理的操作类似
    //widget->setTexCoord(0.0, 0.0, osgWidget::Widget::LOWER_LEFT);
    //widget->setTexCoord(1.0, 0.0, osgWidget::Widget::LOWER_RIGHT);
    //widget->setTexCoord(1.0, 1.0, osgWidget::Widget::UPPER_RIGHT);
    //widget->setTexCoord(0.0, 1.0, osgWidget::Widget::UPPER_LEFT);
    //设置按钮颜色
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

    //添加标签栏实时显示帮助信息
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

	//HUD显示位置
	viewer->setUpViewInWindow(100, 100, 1080, 960);

	//把漫游器加入到场景中
	TravelManipulator::TravelToScene(viewer);

    osg::Group* root = new osg::Group;
    root->addChild(node);
	root->addChild(geode.get());//标记
	root->addChild(createHUD_viewPoint(pos_text));//加入HUD坐标文字

	//osgUtil::Optimizer optimizer ;
	//optimizer.optimize(root) ;
	viewer->addEventHandler(pHUD.get());//HUD坐标
	//viewer->setSceneData(root);
	//viewer->realize();
	//viewer->run();
    return osgWidget::createExample(* viewer, wm, root);

}
