#include "worlddata.hpp"
#include "agentfactory.hpp"


WorldData::WorldData(int width, int height, float a, float b, float reward, float discount, agent_mode mode) throw (chances_not_summing_to_1)
    : width(width), height(height), a(a), b(b), reward(reward), discount(discount), agent(AgentFactory::new_agent(mode))
{
    if (error_too_big()) throw chances_not_summing_to_1();
}

WorldData::~WorldData()
{
    delete agent;
}
