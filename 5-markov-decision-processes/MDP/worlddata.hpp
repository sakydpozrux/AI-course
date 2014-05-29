#ifndef WORLDDATA_HPP
#define WORLDDATA_HPP

#include <cmath>
#include <memory>

#include "consts.hpp"
#include "agent.hpp"

class WorldData
{
public:
    int width;
    int height;
    float a;
    float b;
    float reward;
    float discount;

    WorldData(int width, int height, float a, float b, float reward, float discount);

    ~WorldData();
};

#endif // WORLDDATA_HPP
