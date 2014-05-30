#include <iostream>
#include <cstdlib>
#include <memory>
#include <string>
#include <vector>
#include <boost/scoped_ptr.hpp>

#include "consts.hpp"
#include "field.hpp"
#include "worlddata.hpp"
#include "agentfactory.hpp"
#include "worlddataserializer.hpp"
#include "file.hpp"

void world_and_agent_setup(const int argc, const char** argv,
                           std::shared_ptr<WorldData>& world,
                           std::shared_ptr<Agent>& agent);
//std::shared_ptr<WorldData> choose_correct_world_data(const int argc, const char* argv);


int main(const int argc, const char** argv)
{
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
    const agent_mode mode = VAGENT;

    boost::scoped_ptr<WorldDataSerializer> s;

    if (argc < 2)
    {
        std::string board_string = "-0.04 0.8 0.1 0.9\n"
                                   "_      _      _      G:1  \n"
                                   "_      F      _      G:-1 \n"
                                   "S      _      B:0.2  _    \n";

        s.reset(new WorldDataSerializer(board_string));
    }
    else
    {
        File file = File(std::string(argv[1]));
        s.reset(new WorldDataSerializer(file));
    }

    world.reset(new WorldData(s->get_board(), s->get_a(), s->get_b(), s->get_reward(), s->get_discount()));
    agent.reset(AgentFactory::new_agent(mode, world));
}

