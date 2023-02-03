#pragma once

#include <grpc/grpc.h>
#include <grpcpp/security/server_credentials.h>
#include <grpcpp/server.h>
#include <grpcpp/server_builder.h>
#include <grpcpp/server_context.h>
#include "Your_Project_protocol.grpc.pb.h"

#include <iostream>
#include <string>
#include <memory>


namespace Your_Project 
{
    class Server final : public YourProjectServer::Service
    {
    public:
        Server() = default;
        ~Server() = default;

        void Run();

    private:

    };
    
    Server *CreateServer();

};