#include "field.hpp"

Field::Field(field_state state, float value)
    : state(state), value(value)
{
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
