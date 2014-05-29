#ifndef QAGENT_HPP
#define QAGENT_HPP

#include "agent.hpp"

class QAgent : public Agent
{
public:
    QAgent(std::shared_ptr<WorldData> world);
    virtual ~QAgent();

    virtual void next();
    virtual void best_move(int x, int y); // TODO = specify returning type

    virtual std::string to_string() const;
};

#endif // QAGENT_HPP
