#include "agentfactory.hpp"
#include "vagent.hpp"
#include "qagent.hpp"
#include "consts.hpp"

Agent* AgentFactory::new_agent(agent_mode mode)
{
    switch (mode)
    {
    case VAGENT:
        return new VAgent();
        break;
    case QAGENT:
        return new QAgent();
        break;
    default:
        return new VAgent();
        break;
    }
}
