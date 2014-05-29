#ifndef BOARD_HPP
#define BOARD_HPP

#include <vector>

#include "consts.hpp"
#include "field.hpp"

class Board
{
public:
    Field forbidden_prototype;
    std::vector<std::vector<Field>> board;

    Board(std::vector<std::vector<Field>>& board);

    const Field& at(int x, int y) const;
    Field& at(int x, int y);
    Position starting_position() const;

private:
    inline bool out_of_bounds(int x, int y) const;
};

#endif // BOARD_HPP
