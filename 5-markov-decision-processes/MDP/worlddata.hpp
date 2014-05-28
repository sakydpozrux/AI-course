#ifndef WORLDDATA_HPP
#define WORLDDATA_HPP

#include <cmath>

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

    Agent* agent;

    WorldData(int width, int height, float a, float b, float reward, float discount, agent_mode mode) throw (chances_not_summing_to_1);

    WorldData(const WorldData& other) = delete;
    WorldData& operator=(const WorldData& other) = delete;

    ~WorldData();

private:
    float sum_chances() { return a + b * 2; }
    float chances_diff_from_1() { return fabs(sum_chances() - 1); }
    bool error_too_big() { return (chances_diff_from_1() > max_allowed_error); }
};

#endif // WORLDDATA_HPP
