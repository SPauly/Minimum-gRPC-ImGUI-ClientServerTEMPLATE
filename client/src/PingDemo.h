#pragma once
#include "Layer.h"

#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"

#include <grpc/grpc.h>
#include <grpcpp/channel.h>
#include <grpcpp/client_context.h>
#include <grpcpp/create_channel.h>
#include <grpcpp/security/credentials.h>

namespace Your_Project
{
    class PingDemo : public Layer
    {
    public:
        PingDemo() = default;
        ~PingDemo() = default;

        virtual void OnUIRender() override{
            ImGui::Begin("PingDemo");

            ImGui::End();
        };
    private:

    };
}