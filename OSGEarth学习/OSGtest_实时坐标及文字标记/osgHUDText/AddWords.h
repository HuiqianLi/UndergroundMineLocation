#include <osgViewer/Viewer>

#include <osg/Node>
#include <osg/Geode>
#include <osg/Group>
#include <osg/Geometry>

#include <osgDB/ReadFile>
#include <osgDB/WriteFile>
#include <osgText/Text>

#include <osgUtil/Optimizer>

#include <Windows.h>
#include <locale.h>

void setupProperties(osgText::Text& textObject,osgText::Font* font,float size,const osg::Vec3& pos )
{
   	textObject.setFont(font);//
	textObject.setCharacterSize(size);//字体大小
	textObject.setPosition(pos);
	textObject.setColor(osg::Vec4(1.0,1.0,1.0,1.0));
	textObject.setAlignment(osgText::Text::CENTER_BOTTOM);//文字显示方向
	//textObject.setAxisAlignment(osgText::Text::SCREEN);//获取文字对称成方式正对屏幕方向
	//textObject.setCharacterSizeMode(osgText::Text::SCREEN_COORDS);//跟随视角不断变化，离物体越远，文字越大
	textObject.setAutoRotateToScreen(true);//跟随视角不断变化，但离物体越远，文字越小，和现实当中像类似
	textObject.setBackdropType(osgText::Text::OUTLINE);//对文字进行描边
	textObject.setBackdropColor(osg::Vec4(1.0,0.0,0.0,1.0));//描边颜色
	textObject.setDrawMode(osgText::Text::TEXT | osgText::Text::BOUNDINGBOX);//添加文字边框
    	textObject.setAxisAlignment(osgText::Text::XZ_PLANE);//获取文字对称成方式

}

void createContent(osgText::Text& textObject,const char* string)
{
    int requiredSize=mbstowcs(NULL,string,0);//如果mbstowcs第一参数为NULL那么返回字符串的数目
    wchar_t* wText=new wchar_t[requiredSize+1];
    mbstowcs(wText,string,requiredSize+1);//由char转换成wchar类型
    textObject.setText(wText);
    delete wText;
}