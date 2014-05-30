#include <iostream>
#include <cstdlib>
#include <memory>
#include <string>
#include <vector>

#include "consts.hpp"
#include "field.hpp"
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

    std::vector<std::vector<Field>> field_board;

    if (argc < 2)
    {
        width = 4;
        height = 3;
        a = 0.8;
        b = 0.1;
        reward = -0.04;
        discount = 0.9;

        const agent_mode mode = VAGENT;

        std::string board_string = "-0.04 0.8 0.1 0.9\n"
                                   "_      _      _      G:1  \n"
                                   "_      F      _      G:-1 \n"
                                   "S      _      B:0.2  _    \n";

        field_board = {
            {Field(S, reward), Field(X, reward), Field(X, reward)},
            {Field(X, reward), Field(F, 0), Field(X, reward)},
            {Field(X, reward), Field(X, reward), Field(X, reward)},
            {Field(X, reward), Field(G, -1), Field(G, 1)}
        };

        world.reset(new WorldData(field_board, a, b, reward, discount));
        agent.reset(AgentFactory::new_agent(mode, world));
    }
    else
    {
        std::cout << "argc>=2 case NotYetImplemented\n";
        // TODO
        //std::string filename(argv[1]);

    }
}

