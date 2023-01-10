# Build Variables
set(SUP_FULL_BUILD ON CACHE BOOL "Full build" FORCE)

# Third_Party_Depends Variables
set(SUP_GRPC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external/grpc" CACHE PATH "gRPC Location" FORCE)
set(SUP_GRPC_PRECOMPILED_BINARIES ON CACHE BOOL "Use precompiled binaries for gRPC -> expects Path to build folder with all dependencies. See README" FORCE)
set(SUP_GRPC_PRECOMPILED_BINARIES_DIR "${CMAKE_CURRENT_SOURCE_DIR}/build/third_party" CACHE PATH "Location of precompiled binaries. Has to be set if option is set to ON" FORCE)
set(SUP_GLFW_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external/glfw" CACHE PATH "GLFW Location" FORCE)