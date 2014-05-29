#include "worlddata.hpp"
#include "agentfactory.hpp"


WorldData::WorldData(int width, int height, float a, float b, float reward, float discount)
    : width(width), height(height), a(a), b(b), reward(reward), discount(discount)
{

}

WorldData::~WorldData()
{

}
