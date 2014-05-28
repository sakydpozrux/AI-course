#ifndef CONSTS_HPP
#define CONSTS_HPP

#include <exception>

const float max_allowed_error = 0.01;

struct chances_not_summing_to_1 : std::exception
{
    const char* what() const noexcept
    {
        return "Exception: Chances to move (a+b+b) not summing to 1.";
    }
};

enum agent_mode
{
    VAGENT = 0,
    QAGENT = 1
};


#endif // CONSTS_HPP
