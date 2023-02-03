#include "Server.h"

#include <iostream>

namespace Your_Project
{
    void Server::Run()
    {
        std::cout<<"Server Running. Waiting for Connections"<<std::endl;
        return;
    }

    Server* CreateServer()
    {
        return new Server;
    }
}