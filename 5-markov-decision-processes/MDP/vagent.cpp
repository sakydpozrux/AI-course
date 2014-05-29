#include "vagent.hpp"

VAgent::VAgent(std::shared_ptr<WorldData> world)
    : Agent(world)
{
}

VAgent::~VAgent()
{

}

void VAgent::next()
{

}

void VAgent::best_move(int x, int y) // TODO = specify returning type
{

}

std::string VAgent::to_string() const
{
    std::ostringstream stream;
    stream << "Inside VAgent NotYetImplemented\n"; // TODO
    return stream.str();
}
