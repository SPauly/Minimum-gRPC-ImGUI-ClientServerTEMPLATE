cmake_minimum_required(VERSION 3.5.1)
# set the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -Wall -Wformat")
set(-DCMAKE_RC_COMPILER=windres)

project(client)

set(OpenGL_GL_PREFERENCE GLVND)

link_directories(${imgui_LIB})
find_package(glfw3 3.3 REQUIRED)
find_package(OpenGL REQUIRED)

add_executable(${PROJECT_NAME}
    "${PROJECT_SOURCE_DIR}/src/main.cpp"
    "${PROJECT_SOURCE_DIR}/src/Application.cpp"    
    "${PROJECT_SOURCE_DIR}/src/LayerStack.cpp"    
)

target_link_libraries(${PROJECT_NAME} glfw ${GLFW_LIBRARIES})
target_link_libraries(${PROJECT_NAME} OpenGL::GL)
target_link_libraries(${PROJECT_NAME} ${imgui_DIR})

target_include_directories(${PROJECT_NAME} PUBLIC
    "${PROJECT_SOURCE_DIR}"
    "${PROJECT_SOURCE_DIR}/../utils"
    "${PROJECT_SOURCE_DIR}/src/"
    "${PROJECT_SOURCE_DIR}/../external/imgui"
    "${PROJECT_SOURCE_DIR}/../external/imgui/backends"
    "${PROJECT_SOURCE_DIR}/../build/thir_party/glfw/include/"
)