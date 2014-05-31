#include "agentfactory.hpp"
#include "vagent.hpp"
#include "qagent.hpp"
#include "consts.hpp"

Agent* AgentFactory::new_agent(agent_mode mode, std::shared_ptr<WorldData> world)
{
    switch (mode)
    {
    case VAGENT:
        return new VAgent(world);
        break;
    case QAGENT:
        return new QAgent(world);
        break;
//    default:
//        return new VAgent(world);
//        break;
    }
}
