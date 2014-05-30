#include "direction.hpp"

Direction::Direction()
    : arrow(UNKNOWN)
{
}

std::ostream& operator<<(std::ostream& stream, const Direction& direction)
{
    switch (direction.arrow)
    {
    case UP:
        stream << '^';
        break;
    case DOWN:
        stream << 'v';
        break;
    case LEFT:
        stream << '<';
        break;
    case RIGHT:
        stream << '>';
        break;
    default:
        stream << ' ';
    }

    return stream;
}
