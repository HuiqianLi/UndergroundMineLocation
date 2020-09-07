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
	textObject.setCharacterSize(size);//�����С
	textObject.setPosition(pos);
	textObject.setColor(osg::Vec4(1.0,1.0,1.0,1.0));
	textObject.setAlignment(osgText::Text::CENTER_BOTTOM);//������ʾ����
	//textObject.setAxisAlignment(osgText::Text::SCREEN);//��ȡ���ֶԳƳɷ�ʽ������Ļ����
	//textObject.setCharacterSizeMode(osgText::Text::SCREEN_COORDS);//�����ӽǲ��ϱ仯��������ԽԶ������Խ��
	textObject.setAutoRotateToScreen(true);//�����ӽǲ��ϱ仯����������ԽԶ������ԽС������ʵ����������
	textObject.setBackdropType(osgText::Text::OUTLINE);//�����ֽ������
	textObject.setBackdropColor(osg::Vec4(1.0,0.0,0.0,1.0));//�����ɫ
	textObject.setDrawMode(osgText::Text::TEXT | osgText::Text::BOUNDINGBOX);//������ֱ߿�
    	textObject.setAxisAlignment(osgText::Text::XZ_PLANE);//��ȡ���ֶԳƳɷ�ʽ

}

void createContent(osgText::Text& textObject,const char* string)
{
    int requiredSize=mbstowcs(NULL,string,0);//���mbstowcs��һ����ΪNULL��ô�����ַ�������Ŀ
    wchar_t* wText=new wchar_t[requiredSize+1];
    mbstowcs(wText,string,requiredSize+1);//��charת����wchar����
    textObject.setText(wText);
    delete wText;
}