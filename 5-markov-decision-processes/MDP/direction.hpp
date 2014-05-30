#ifndef DIRECTION_HPP
#define DIRECTION_HPP

#include <sstream>

#include "consts.hpp"

class Direction
{
    direction_arrow arrow;

public:
    Direction();

    friend std::ostream& operator<<(std::ostream& stream, const Direction& direction);
};

#endif // DIRECTION_HPP
