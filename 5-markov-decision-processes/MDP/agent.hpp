#ifndef AGENT_HPP
#define AGENT_HPP

#include <memory>
#include <sstream>

#include "consts.hpp"

class WorldData;

class Agent
{
public:
    std::shared_ptr<WorldData> world;

    Agent(std::shared_ptr<WorldData> world);
    virtual ~Agent();

    virtual void next() = 0;
    virtual void best_move(int x, int y) = 0; // TODO = specify returning type

    virtual std::string to_string() const = 0;
};

#endif // AGENT_HPP
