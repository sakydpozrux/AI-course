#include "board.hpp"

Board::Board(std::vector<std::vector<Field>>& board)
    : forbidden_prototype(F, 0), board(board)
{
}

const Field& Board::at(int x, int y) const
{
    if (out_of_bounds(x, y)) return forbidden_prototype;
    return board.at(x).at(y);
}

Field& Board::at(int x, int y)
{
    if (out_of_bounds(x, y)) return forbidden_prototype;
    return board.at(x).at(y);
}

Position Board::starting_position() const
{
    for(int x = 0; x < (int)board.size(); ++x)
        for(int y = 0; y < (int)board[0].size(); ++x)
            if (at(x, y).is_starting()) return Position(x, y);

    return Position(0, 0);
}

inline bool Board::out_of_bounds(int x, int y) const
{
    bool out_of_x = x < 0 || x > (int)board.size();
    bool out_of_y = y < 0 || y > (int)board[0].size();

    return out_of_x || out_of_y;
}
