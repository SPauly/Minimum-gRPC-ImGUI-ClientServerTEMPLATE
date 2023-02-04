#pragma once

#include <memory>

#include "Layer.h"

#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"

#include <grpc/grpc.h>
#include <grpcpp/channel.h>
#include <grpcpp/client_context.h>

#include "Your_Project_protocol.grpc.pb.h"

namespace Your_Project
{
    class PingDemo : public Layer
    {
    public:
        PingDemo() = default;
        PingDemo(std::shared_ptr<grpc::Channel> _channel) : msprt_channel(_channel) {};
        ~PingDemo() = default;

        virtual void OnUIRender() override{
            ImGui::Begin("PingDemo");
                if(ImGui::Button("Ping Server"))
                {

                }
            ImGui::End();
        };
    private:
        std::shared_ptr<grpc::Channel> msprt_channel;
        std::unique_ptr<YourProject::YourProjectServer::Stub> m_stub;
    };
}