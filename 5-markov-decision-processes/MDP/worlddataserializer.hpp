#ifndef WORLDDATASERIALIZER_HPP
#define WORLDDATASERIALIZER_HPP

#include <string>
#include <list>

#include "worlddata.hpp"
#include "file.hpp"

class WorldDataSerializer
{
private:
    std::string contents;
    std::list<std::string> lines;
    std::vector<std::vector<Field> > board;

    int a;
    int b;
    float reward;
    float discount;

public:
    WorldDataSerializer(const std::string& path);
    WorldDataSerializer(const File& file);

    std::vector<std::vector<Field>>& get_board();

    size_t get_width() const;
    size_t get_height() const;
    int get_a() const;
    int get_b() const;
    float get_reward() const;
    float get_discount() const;

private:
    std::list<std::string> split_lines();
    std::vector<std::vector<Field> > parse_board();
};

#endif // WORLDDATASERIALIZER_HPP
