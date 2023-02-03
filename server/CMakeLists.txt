cmake_minimum_required(VERSION 3.5.1)
# set the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -Wall -Wformat")
set(-DCMAKE_RC_COMPILER=windres)

message(STATUS "grpc Binaries is: ${SUP_GRPC_BINARIES_DIR}/grpc/include")

project(server)

include(${SUP_ROOT_FOLDER}/cmake/common.cmake)
link_directories(${SUP_ROOT_FOLDER}/build/utils)
link_directories(${SUP_GRPC_BINARIES_DIR}/grpc/lib)
link_directories(${SUP_GRPC_BINARIES_DIR}/protobuf/lib)

add_executable(server
    "${PROJECT_SOURCE_DIR}/src/main.cpp"
    "${PROJECT_SOURCE_DIR}/src/Server.cpp"    
)

target_include_directories(server PUBLIC
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/src
    ${SUP_ROOT_FOLDER}/utils
)

target_link_libraries(${PROJECT_NAME}
sup_grpc_proto
${_REFLECTION}
${_GRPC_GRPCPP}
${_PROTOBUF_LIBPROTOBUF}
)