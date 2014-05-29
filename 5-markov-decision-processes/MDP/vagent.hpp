#ifndef VAGENT_HPP
#define VAGENT_HPP

#include "agent.hpp"

class VAgent : public Agent
{
public:
    VAgent(std::shared_ptr<WorldData> world);
    virtual ~VAgent();

    virtual void next();
    virtual void best_move(int x, int y); // TODO = specify returning type

    virtual std::string to_string() const;
};

#endif // VAGENT_HPP
