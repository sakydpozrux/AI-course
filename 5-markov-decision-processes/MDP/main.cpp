#include <iostream>
#include <cstdlib>
#include <memory>

#include "worlddata.hpp"
#include "agentfactory.hpp"

// TODO REMOVE BELOW
#include "qagent.hpp"

int main()
{
    int width = 4;
    int height = 3;
    float a = 0.8;
    float b = 0.1;
    float reward = 1 / 25;
    float discount = 0.5;
    agent_mode mode = VAGENT;

    std::shared_ptr<WorldData> world(new WorldData(width, height, a, b, reward, discount));
    std::shared_ptr<Agent> exampleagent(AgentFactory::new_agent(mode, world));
    std::cout << exampleagent->to_string();

    return EXIT_SUCCESS;
}

