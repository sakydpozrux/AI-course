#ifndef AGENTFACTORY_HPP
#define AGENTFACTORY_HPP

#include <memory>

#include "worlddata.hpp"
#include "agent.hpp"

class AgentFactory
{
public:
    static Agent* new_agent(agent_mode mode, std::shared_ptr<WorldData> world);
};

#endif // AGENTFACTORY_HPP
