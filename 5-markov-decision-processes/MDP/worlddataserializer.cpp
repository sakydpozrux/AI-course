#include <sstream>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>

#include "worlddataserializer.hpp"


WorldDataSerializer::WorldDataSerializer(const std::string& contents_)
    : contents(contents_), lines(), board()
{
    boost::trim(contents);
    lines = split_lines();
    board = parse_board();
}

WorldDataSerializer::WorldDataSerializer(const File& file)
    : contents(file.contents()), lines(), board()
{
    boost::trim(contents);
}

std::vector<std::vector<Field> >& WorldDataSerializer::get_board()
{
    return board;
}

size_t WorldDataSerializer::get_width() const
{
    return board.size();
}

size_t WorldDataSerializer::get_height() const
{
    return board.at(0).size();
}

int WorldDataSerializer::get_a() const
{
    return a;
}

int WorldDataSerializer::get_b() const
{
    return b;
}

float WorldDataSerializer::get_reward() const
{
    return reward;
}

float WorldDataSerializer::get_discount() const
{
    return discount;
}

std::list<std::string> WorldDataSerializer::split_lines()
{
    std::list<std::string> lines;
    boost::split(lines, contents, boost::is_any_of("\n"), boost::token_compress_on);
    return lines;
}

std::vector<std::vector<Field> > WorldDataSerializer::parse_board()
{
    auto it = lines.begin();
    std::string header_raw = *it;
    std::vector<std::string> header_vector;
    boost::split(header_vector, header_raw, boost::is_any_of(" \t"), boost::token_compress_on);

      reward = boost::lexical_cast<float>(header_vector.at(0));
           a = boost::lexical_cast<float>(header_vector.at(1));
           b = boost::lexical_cast<float>(header_vector.at(2));
    discount = boost::lexical_cast<float>(header_vector.at(3));

    std::vector<std::vector<Field> > board;

    std::list<std::list<std::string> > board_raw;

    for (++it; it != lines.end(); ++it)
    {
        std::list<std::string> current_line;
        boost::split(current_line, *it, boost::is_any_of(" \t"), boost::token_compress_on);
        board_raw.push_front(current_line);

        // BIG TODO -- creating corrent Field from this raw strings
    }

    return board;
}
