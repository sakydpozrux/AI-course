#ifndef FIELD_HPP
#define FIELD_HPP

#include "consts.hpp"
#include "direction.hpp"

class Field
{
public:
    field_state state;
    float value;
    Direction direction;

    Field(field_state state, float value);
    Field(const std::string& string, float reward);

    field_state get_state() const;

    float get_value() const;
    void set_value(float v);

    Direction get_direction();
    void set_direction(Direction d);

    bool is_default() const;
    bool is_terminal() const;
    bool is_starting() const;
    bool is_forbidden() const;
    bool is_special() const;

    friend std::ostream& operator<<(std::ostream& stream, const Field& field);
};

#endif // FIELD_HPP
