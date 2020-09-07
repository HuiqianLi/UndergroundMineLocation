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
//�¼���
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

	osg::Vec3 m_vPosEye;//�ӵ�����
	osg::ref_ptr<osgText::Text> m_text;//�ӵ���Ϣ���ᶯ̬�ı�

};

osg::Vec3 CHUD_viewPoint::GetM_VPosEye(){
		return m_vPosEye;//�ӵ�����
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
			viewer->getCamera()->getViewMatrixAsLookAt(m_vPosEye, vCenter, vUp);//��ȡ�ӵ���Ϣ
			UpdateText(viewer, ea);//����������Ϣ       
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
	//����

	//osgText::Text* text = new osgText::Text;   
	//��������
	std::string caiyun("C:\\WINDOWS\\Fonts\\simkai.ttf");//�˴����õ��Ǻ�������
	text->setFont(caiyun);
	//����������ʾ��λ��
	osg::Vec3 position(100.0f, 100.0f, 0.0f);
	text->setPosition(position);
	text->setColor(osg::Vec4(1, 1, 0, 1));
	text->setText(L"");//������ʾ������
	text->setCharacterSize(15);
	text->setDataVariance(osg::Object::DYNAMIC);//һ��Ҫ��������Ϊ��̬���������Ῠס���������������osgcatch��
												//������ڵ�

	osg::Geode* geode = new osg::Geode();
	geode->addDrawable(text);//������Text����drawable���뵽Geode�ڵ���

	 //����״̬
	osg::StateSet* stateset = geode->getOrCreateStateSet();
	stateset->setMode(GL_LIGHTING, osg::StateAttribute::OFF);//�رյƹ�
	stateset->setMode(GL_DEPTH_TEST, osg::StateAttribute::OFF);//�ر���Ȳ���
	 //��GL_BLEND���ģʽ���Ա�֤Alpha������
	stateset->setMode(GL_BLEND, osg::StateAttribute::ON);
	//���
	osg::Camera* camera = new osg::Camera;
	//����͸�Ӿ���
	camera->setProjectionMatrix(osg::Matrix::ortho2D(0, 600, 0, 600));//����ͶӰ   
	//���þ��Բο�����ϵ��ȷ����ͼ���󲻻ᱻ�ϼ��ڵ�ı任����Ӱ��
	camera->setReferenceFrame(osg::Transform::ABSOLUTE_RF);

	//��ͼ����ΪĬ�ϵ�
	camera->setViewMatrix(osg::Matrix::identity());
	//���ñ���Ϊ͸��������Ļ���������ClearColor 
	camera->setClearMask(GL_DEPTH_BUFFER_BIT);
	camera->setAllowEventFocus(false);//����Ӧ�¼���ʼ�յò�������
	//������Ⱦ˳�򣬱����������Ⱦ
	camera->setRenderOrder(osg::Camera::POST_RENDER);
	camera->addChild(geode);//��Ҫ��ʾ��Geode�ڵ���뵽���
	return camera;
};