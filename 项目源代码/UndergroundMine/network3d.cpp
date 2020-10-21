#include "network3d.h"

Network3D::Network3D()
{

}

void Network3D::addMineline(std::string mineName, osg::Vec3d p1, osg::Vec3d p2)
{
    double distance = (p1 -p2).length();
    m_mineLength[mineName] += distance;
}

double Network3D::getLengthByMineName(std::string mineName)
{
    return m_mineLength[mineName];
}

void Network3D::setMineRadius(std::string mineName, double radius)
{
    m_mineRadius[mineName] = radius;
}

double Network3D::getRadiusByMineName(std::string mineName)
{
    return m_mineRadius[mineName];
}
