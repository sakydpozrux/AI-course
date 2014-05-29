#include <iostream>
#include <cstdlib>
#include <memory>
#include <string>

#include "worlddata.hpp"
#include "agentfactory.hpp"

void world_and_agent_setup(const int argc, const char** argv,
                           std::shared_ptr<WorldData>& world,
                           std::shared_ptr<Agent>& agent);
//std::shared_ptr<WorldData> choose_correct_world_data(const int argc, const char* argv);


int main(const int argc, const char** argv)
{
    // TODO user WorldDataSerializer
    // world.reset(WorldDataSerializer::parse_world(input_file);

    std::shared_ptr<WorldData> world;
    std::shared_ptr<Agent> agent;

    world_and_agent_setup(argc, argv, world, agent);

    std::cout << agent->to_string();

    return EXIT_SUCCESS;
}

void world_and_agent_setup(const int argc, const char** argv,
                           std::shared_ptr<WorldData>& world,
                           std::shared_ptr<Agent>& agent)
{
    int width, height;
    float a, b, reward, discount;

    if (argc < 2)
    {
        width = 4;
        height = 3;
        a = 0.8;
        b = 0.1;
        reward = 1 / 25;
        discount = 0.5;

        const agent_mode mode = VAGENT;

        world.reset(new WorldData(width, height, a, b, reward, discount));
        agent.reset(AgentFactory::new_agent(mode, world));
    }
    else
    {
        std::cout << "argc>=2 case NotYetImplemented\n";
        // TODO
        //std::string filename(argv[1]);

    }
}

