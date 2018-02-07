# cmake 生成 工程
# cmake -G "Visual Studio 14 2015" ..
#           指定的平台				CMakeLists.txt的目录

# Minimum CMake required
cmake_minimum_required(VERSION 2.8.12)			# 指定 cmake的最低版本

# include 添加其他cmake 文件

include(language.cmake) # 语言相关cmake说明

include(project.cmake) # 工程相关cmake说明

