#pragma once

#include "Your_Project_protocol.grpc.pb.h"

#include <iostream>
#include <string>
#include <memory>


namespace Your_Project 
{
    class Server final : public YourProject::YourProjectServer::Service
    {
    public:
        Server() = default;
        ~Server() = default;

        void Run();

    private:
        YourProject::Id something;        
    };
    
    Server *CreateServer();

};