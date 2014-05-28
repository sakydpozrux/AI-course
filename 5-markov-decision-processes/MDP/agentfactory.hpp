#ifndef AGENTFACTORY_HPP
#define AGENTFACTORY_HPP

#include "agent.hpp"

class AgentFactory
{
public:
    static Agent* new_agent(agent_mode mode);
};

#endif // AGENTFACTORY_HPP
