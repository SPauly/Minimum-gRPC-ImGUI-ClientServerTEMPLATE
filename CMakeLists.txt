cmake_minimum_required(VERSION 3.5.1)
# set the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -Wall -Wformat")
set(-DCMAKE_RC_COMPILER=windres)

project(Your_Project)

include(cmake/costum-config.cmake)
include(ExternalProject)

# Build third_party_dependencies
if(SUP_FULL_BUILD)
message(STATUS "Adding Third Party Dependencies")
message(STATUS "Using gRPC Location: ${SUP_GRPC_DIR}")
message(STATUS "Using GLFW Location: ${SUP_GLFW_DIR}")

  ExternalProject_Add(Third_Party_Depends
      PREFIX external
      SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external"
      BINARY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/build/third_party"
      INSTALL_COMMAND ""
      CMAKE_CACHE_ARGS
          -DSUP_GRPC_DIR:PATH=${SUP_GRPC_DIR}
          -DSUP_GLFW_DIR:PATH=${SUP_GLFW_DIR}
          -DSUP_GRPC_PRECOMPILED_BINARIES:BOOL=${SUP_GRPC_PRECOMPILED_BINARIES}
          -DSUP_GRPC_PRECOMPILED_BINARIES_DIR:PATH=${SUP_GRPC_PRECOMPILED_BINARIES_DIR}
          -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_BINARY_DIR}/Third_Party_Depends
  )
endif() 