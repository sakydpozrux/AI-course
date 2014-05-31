#ifndef FILE_HPP
#define FILE_HPP

#include <string>

class File
{
    std::string path;
public:
    File(const std::string& path);

    std::string contents() const;
};

#endif // FILE_HPP
