#ifndef NETWORK3D_H
#define NETWORK3D_H

#include <map>
#include <string>
#include <osg/Vec3d>
#include <Windows.h>
class Network3D
{
public:
    Network3D();

    void addMineline(std::string mineName, osg::Vec3d p1, osg::Vec3d p2);
    void setMineRadius(std::string mineName, double radius);
    double getLengthByMineName(std::string mineName);
    double getRadiusByMineName(std::string mineName);

private:
    std::map<std::string, double> m_mineLength;
    std::map<std::string, double> m_mineRadius;
    std::map<osg::Vec3d, unsigned> m_minePointNum;
    unsigned maxNumber = 0;
};

#endif // NETWORK3D_H
