#ifndef WORLDDATA_HPP
#define WORLDDATA_HPP

#include <cmath>
#include <memory>
#include <vector>

#include "consts.hpp"
#include "agent.hpp"
#include "field.hpp"

class WorldData
{
public:
    std::vector<std::vector<Field>> board;
    Field forbidden_prototype;

    int width;
    int height;
    float a;
    float b;
    float reward;
    float discount;

    WorldData(std::vector<std::vector<Field>>& board, float a, float b, float reward, float discount);

    const Field& at(int x, int y) const;
    Field& at(int x, int y);
    Position starting_position() const;

private:
    inline bool out_of_bounds(int x, int y) const;
};

#endif // WORLDDATA_HPP
