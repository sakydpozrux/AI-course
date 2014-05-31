#ifndef CONSTS_HPP
#define CONSTS_HPP

#include <exception>
#include <utility>

typedef std::pair<int, int> Position;

const float max_allowed_error = 0.01;

enum field_state
{
    X, // default
    G, // terminal
    S, // starting
    F, // forbidden
    B  // special
};

enum agent_mode
{
    VAGENT = 0,
    QAGENT = 1
};

enum direction_arrow
{
    UNKNOWN,
    UP,
    DOWN,
    LEFT,
    RIGHT
};

#endif // CONSTS_HPP
