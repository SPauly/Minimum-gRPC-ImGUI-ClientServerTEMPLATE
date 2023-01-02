cmake_minimum_required(VERSION 3.5.1)
# set the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -Wall -Wformat")
set(-DCMAKE_RC_COMPILER=windres)

project(client)

include(cmake/common.cmake)
  set(OpenGL_GL_PREFERENCE GLVND)
  
  find_package(glfw3 3.3 REQUIRED)
  find_package(OpenGL REQUIRED)
  
  add_executable(${PROJECT_NAME}
      "${PROJECT_SOURCE_DIR}/src/main.cpp"
      "${PROJECT_SOURCE_DIR}/src/Application.cpp"
      "${PROJECT_SOURCE_DIR}/src/utils/LayerStack.cpp"
  )
  
  #Dear ImGui
  add_library(imgui
      "${PROJECT_SOURCE_DIR}/external/imgui/imgui.cpp"
      "${PROJECT_SOURCE_DIR}/external/imgui/imgui_demo.cpp"
      "${PROJECT_SOURCE_DIR}/external/imgui/imgui_draw.cpp"
      "${PROJECT_SOURCE_DIR}/external/imgui/imgui_tables.cpp"
      "${PROJECT_SOURCE_DIR}/external/imgui/imgui_widgets.cpp"
      "${PROJECT_SOURCE_DIR}/external/imgui/backends/imgui_impl_opengl3.cpp"
      "${PROJECT_SOURCE_DIR}/external/imgui/backends/imgui_impl_glfw.cpp"
      )
  
  target_include_directories(imgui PUBLIC
      "${PROJECT_SOURCE_DIR}/external/imgui"
      "${PROJECT_SOURCE_DIR}/external/imgui/backends"
      "${PROJECT_SOURCE_DIR}/build/third_party/glfw/include"
  )
  
  target_link_libraries(${PROJECT_NAME} glfw ${GLFW_LIBRARIES})
  target_link_libraries(${PROJECT_NAME} OpenGL::GL)
  target_link_libraries(${PROJECT_NAME} imgui)
  target_link_libraries(${PROJECT_NAME}
  hab_grpc_proto
  ${_REFLECTION}
  ${_GRPC_GRPCPP}
  ${_PROTOBUF_LIBPROTOBUF})
  
  target_include_directories(${PROJECT_NAME} PUBLIC
      "${PROJECT_SOURCE_DIR}"
      "${PROJECT_SOURCE_DIR}/utils"
      "${PROJECT_SOURCE_DIR}/src/"
      "${PROJECT_SOURCE_DIR}/src/utils"
      "${PROJECT_SOURCE_DIR}/external/imgui"
      "${PROJECT_SOURCE_DIR}/external/imgui/backends"
      "${PROJECT_SOURCE_DIR}/build/thir_party/glfw/include/"
  )

  add_dependencies(${PROJECT_NAME} Utilities)

  #########
  # Debug #
  #########
  
  set(CMAKE_CXX_FLAGS_DEBUG "-g -Og")
  
  target_compile_definitions(${PROJECT_NAME} PRIVATE
      $<$<CONFIG:Debug>:DEBUG>
  )
  
  ###########
  # Release #
  ###########
  
  set(CMAKE_CXX_FLAGS_RELEASE "-O2 -march=native")
  
  target_compile_definitions(${PROJECT_NAME} PRIVATE
      $<$<CONFIG:Release>:RELEASE>
  )
  
  ##################
  # RelWithDebInfo #
  ##################
  
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELEASE} -g -fno-omit-frame-pointer -rdynamic")
  
  target_compile_definitions(${PROJECT_NAME} PRIVATE
      $<$<CONFIG:Release>:RELEASE>
  )