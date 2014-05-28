#include <iostream>
#include <cstdlib>

#include "worlddata.hpp"

int main()
{
    int width = 4;
    int height = 3;
    float a = 0.8;
    float b = 0.1;
    float reward = 1 / 25;
    float discount = 0.5;
    agent_mode mode = VAGENT;

    WorldData* world;
    try
    {
        world = new WorldData(width, height, a, b, reward, discount, mode);
    }
    catch (std::exception& e)
    {
        std::cout << e.what() << std::endl;
        exit(EXIT_FAILURE);
    }

    delete world;
    return EXIT_SUCCESS;
}

