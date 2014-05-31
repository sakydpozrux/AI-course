#include "worlddata.hpp"
#include "agentfactory.hpp"


WorldData::WorldData(std::vector<std::vector<Field>>& board, float a, float b, float reward, float discount)
    : board(board), forbidden_prototype(F, 0), width((int)board.size()), height((int)board[0].size()), a(a), b(b), reward(reward), discount(discount)
{

}

const Field& WorldData::at(int x, int y) const
{
    if (out_of_bounds(x, y)) return forbidden_prototype;
    return board.at(x).at(y);
}

Field& WorldData::at(int x, int y)
{
    if (out_of_bounds(x, y)) return forbidden_prototype;
    return board.at(x).at(y);
}

Position WorldData::starting_position() const
{
    for(int x = 0; x < width; ++x)
        for(int y = 0; y < height; ++x)
            if (at(x, y).is_starting()) return Position(x, y);

    return Position(0, 0);
}

inline bool WorldData::out_of_bounds(int x, int y) const
{
    bool out_of_x = x < 0 || x > width;
    bool out_of_y = y < 0 || y > height;

    return out_of_x || out_of_y;
}
