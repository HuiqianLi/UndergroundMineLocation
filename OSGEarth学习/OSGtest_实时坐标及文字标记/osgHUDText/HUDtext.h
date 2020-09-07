#include <osgViewer/Viewer>

#include <osg/Node>
#include <osg/Group>
#include <osg/Geode>
#include <osg/Matrix>
#include <osg/Camera>

#include <osgDB/ReadFile>
#include <osgDB/WriteFile>

#include <osgUtil/Optimizer>

#include <osgText/Text>
#include <osgText/Font>
#include "Common.h"
//事件类
class CHUD_viewPoint : public osgGA::GUIEventHandler
{
public:
	CHUD_viewPoint(osgText::Text* updateText):m_text(updateText) {}

	~CHUD_viewPoint() {}

	virtual bool handle(const osgGA::GUIEventAdapter& ea, osgGA::GUIActionAdapter& aa);
	void UpdateText(osgViewer::Viewer* viewer, const osgGA::GUIEventAdapter&);

	void setLabel(const std::string& name)
	{
		if (m_text.get())
		{
			m_text->setText(name);
		}
	}
	osg::Vec3 GetM_VPosEye();

protected:

	osg::Vec3 m_vPosEye;//视点坐标
	osg::ref_ptr<osgText::Text> m_text;//视点信息，会动态改变

};

osg::Vec3 CHUD_viewPoint::GetM_VPosEye(){
		return m_vPosEye;//视点坐标
	}

bool CHUD_viewPoint::handle(const osgGA::GUIEventAdapter& ea, osgGA::GUIActionAdapter& aa)
{
	switch (ea.getEventType())
	{
	case(osgGA::GUIEventAdapter::FRAME):
	{
		osgViewer::Viewer* viewer = dynamic_cast<osgViewer::Viewer*>(&aa);
		if (viewer)
		{
			osg::Vec3 vCenter, vUp;
			viewer->getCamera()->getViewMatrixAsLookAt(m_vPosEye, vCenter, vUp);//获取视点信息
			UpdateText(viewer, ea);//更新文字信息       
		}
		return true;

	}
	default:
		return false;
	}

}

void CHUD_viewPoint::UpdateText(osgViewer::Viewer* viewer, const osgGA::GUIEventAdapter&)
{
	std::string gdlist = "";
	std::ostringstream os;
	os << "Eye( X: " << m_vPosEye[0] << "     Y: " << m_vPosEye[1] << "      Z: " << m_vPosEye[2] << ")";
	gdlist = os.str();
	setLabel(gdlist);

}

osg::Node* createHUD_viewPoint(osgText::Text* text)
{
	//文字

	//osgText::Text* text = new osgText::Text;   
	//设置字体
	std::string caiyun("C:\\WINDOWS\\Fonts\\simkai.ttf");//此处设置的是汉字字体
	text->setFont(caiyun);
	//设置文字显示的位置
	osg::Vec3 position(100.0f, 100.0f, 0.0f);
	text->setPosition(position);
	text->setColor(osg::Vec4(1, 1, 0, 1));
	text->setText(L"");//设置显示的文字
	text->setCharacterSize(15);
	text->setDataVariance(osg::Object::DYNAMIC);//一定要设置字体为动态，否则程序会卡住，死在那里。（参照osgcatch）
												//几何体节点

	osg::Geode* geode = new osg::Geode();
	geode->addDrawable(text);//将文字Text作这drawable加入到Geode节点中

	 //设置状态
	osg::StateSet* stateset = geode->getOrCreateStateSet();
	stateset->setMode(GL_LIGHTING, osg::StateAttribute::OFF);//关闭灯光
	stateset->setMode(GL_DEPTH_TEST, osg::StateAttribute::OFF);//关闭深度测试
	 //打开GL_BLEND混合模式（以保证Alpha纹理正
	stateset->setMode(GL_BLEND, osg::StateAttribute::ON);
	//相机
	osg::Camera* camera = new osg::Camera;
	//设置透视矩阵
	camera->setProjectionMatrix(osg::Matrix::ortho2D(0, 600, 0, 600));//正交投影   
	//设置绝对参考坐标系，确保视图矩阵不会被上级节点的变换矩阵影响
	camera->setReferenceFrame(osg::Transform::ABSOLUTE_RF);

	//视图矩阵为默认的
	camera->setViewMatrix(osg::Matrix::identity());
	//设置背景为透明，否则的话可以设置ClearColor 
	camera->setClearMask(GL_DEPTH_BUFFER_BIT);
	camera->setAllowEventFocus(false);//不响应事件，始终得不到焦点
	//设置渲染顺序，必须在最后渲染
	camera->setRenderOrder(osg::Camera::POST_RENDER);
	camera->addChild(geode);//将要显示的Geode节点加入到相机
	return camera;
};