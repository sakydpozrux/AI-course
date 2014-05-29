#include "qagent.hpp"

QAgent::QAgent(std::shared_ptr<WorldData> world)
    : Agent(world)
{
}

QAgent::~QAgent()
{

}

void QAgent::next()
{

}

void QAgent::best_move(int x, int y) // TODO = specify returning type
{

}

std::string QAgent::to_string() const
{
    std::ostringstream stream;
    stream << "Inside QAgent NotYetImplemented\n"; // TODO
    return stream.str();
}
