#include <string>
#include <boost/lexical_cast.hpp>

#include "field.hpp"

Field::Field(field_state state, float value)
    : state(state), value(value), direction()
{
}

Field::Field(const std::string& string, float reward)
    : state(X), value(reward), direction()
{
    if (string.at(0) == '_')
    {
        state = X;
        value = reward;
    }
    else if (string.at(0) == 'G')
    {
        state = G;
        value = boost::lexical_cast<float>(string.substr(2));
    }
    else if (string.at(0) == 'S')
    {
        state = S;
        value = reward;
    }
    else if (string.at(0) == 'F')
    {
        state = F;
        value = 0;
    }
    else if (string.at(0) == 'B')
    {
        state = B;
        value = boost::lexical_cast<float>(string.substr(2));
    }
}

field_state Field::get_state() const
{
    return state;
}

float Field::get_value() const
{
    return value;
}

void Field::set_value(float v)
{
    value = v;
}

Direction Field::get_direction()
{
    return direction;
}

void Field::set_direction(Direction d)
{
    direction = d;
}

bool Field::is_default() const
{
    return state == X;
}

bool Field::is_terminal() const
{
    return state == G;
}

bool Field::is_starting() const
{
    return state == S;
}

bool Field::is_forbidden() const
{
    return state == F;
}

bool Field::is_special() const
{
    return state == B;
}


std::ostream& operator<<(std::ostream& stream, const Field& field)
{
    std::string string_state;
    switch (field.state)
    {
    case X:
        string_state = '_';
        break;
    case G:
        string_state = 'G';
        break;
    case S:
        string_state = 'S';
        break;
    case F:
        string_state = 'F';
        break;
    case B:
        string_state = 'B';
        break;
    }

    stream << "(" << string_state << ":" << field.value << ")";
    return stream;
}
