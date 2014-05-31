#include <fstream>

#include "file.hpp"

File::File(const std::string& path)
    : path(path)
{
}

std::string File::contents() const
{
    std::ifstream file(path);

    std::string contents((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    return contents;
}
