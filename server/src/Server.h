#pragma once

#include <string>

namespace Your_Project
{
    class Server
    {
    public:
        Server() = default;
        ~Server() = default;

        void Run();

    private:

    };
    
    Server *CreateServer();

};