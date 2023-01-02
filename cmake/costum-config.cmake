# Build Variables
set(SUP_FULL_BUILD ON CACHE BOOL "Full build" FORCE)

# Third_Party_Depends Variables
set(SUP_GRPC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external/grpc" CACHE PATH "gRPC Location" FORCE)
set(SUP_GLFW_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external/glfw" CACHE PATH "GLFW Location" FORCE)
