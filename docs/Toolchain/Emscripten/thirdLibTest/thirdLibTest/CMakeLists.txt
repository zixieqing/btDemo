cmake_minimum_required(VERSION 3.0) # 根据你的需求进行修改
project(thirdLibTest CXX)

set(CMAKE_CXX_STANDARD  11) # 根据你的C编译器支持情况进行修改
set(CMAKE_EXECUTABLE_SUFFIX ".html") # 编译生成.html

include_directories(cJSON) # 使得我们能引用第三方库的头文件
add_subdirectory(cJSON)

add_executable(thirdLibTest main.cpp)

# 设置Emscripten的编译链接参数，我们等等会讲到一些常用参数
set_target_properties(thirdLibTest PROPERTIES LINK_FLAGS "-s EXIT_RUNTIME=1")
target_link_libraries(thirdLibTest cjson) # 将第三方库与主程序进行链接