
############################ Project ##################################

project(cmakeguide C CXX) # 指定工程的语言类型 cmakeguide:工程名(相当于vs的solution) , C CXX 支持的语言类型 
                          # 这个函数会设置这几个变量
                          #PROJECT_SOURCE_DIR, <PROJECT-NAME>_SOURCE_DIR        CMakeLists.txt 的文件路径
                          #PROJECT_BINARY_DIR, <PROJECT-NAME>_BINARY_DIR        执行cmake命令的路径

message( "PROJECT_SOURCE_DIR : " ${PROJECT_SOURCE_DIR} )
message( "<PROJECT-NAME>_SOURCE_DIR : " ${cmakeguide_SOURCE_DIR} )
message( "PROJECT_BINARY_DIR : " ${PROJECT_BINARY_DIR} )
message( "PROJECT_SOURCE_DIR : " ${cmakeguide_BINARY_DIR} )

get_filename_component( SOURCE_DIR ${cmakeguide_SOURCE_DIR} PATH) # SOURCE_DIR 为 设置 cmakeguide_SOURCE_DIR 的父目录 
                                                                  # get_filename_component 函数说明 详见:
                                                                  # https://cmake.org/cmake/help/v3.0/command/get_filename_component.html
message("SOURCE_DIR : " ${SOURCE_DIR})

if (MSVC)
  add_definitions(-DWin32) # 添加 宏定义Win32
endif (MSVC)


############################ 静态库 ##################################

set(static_files
  ${SOURCE_DIR}/libstatic/libstatic.h
  ${SOURCE_DIR}/libstatic/libstatic.cpp
)

add_library(libstatic STATIC ${static_files})  # 添加一个静态库 libstatic , 使用 static_files 的文件

target_include_directories(libstatic PUBLIC ${SOURCE_DIR}/libstatic)  # libstatic 添加 include 目录 , PUBLIC 表示 包含libstatic库的其他库或者进程也include这个目录
                                                                      # 也可使用 PRIVATE 表示 只这个库使用,包含libstatic库的,不include这个目录


target_compile_definitions(libstatic PUBLIC LIBSTATIC)                # 添加宏定义 , PUBLIC 表示 包含这个libstatic库的其他库或者进程也有这个宏定义
                                                                      # 也可使用 PRIVATE 表示 只这个库使用,包含这个库的,没有这个宏定义

set(DEBUG_POSTFIX "_d" )

set_target_properties(libstatic PROPERTIES
    OUTPUT_NAME ${LIB_PREFIX}libstatic
    DEBUG_POSTFIX "${DEBUG_POSTFIX}")         # 设置属性,属性列表见 https://cmake.org/cmake/help/v3.8/manual/cmake-properties.7.html#target-properties


############################ 动态库 ##################################

set(shared_files
  ${SOURCE_DIR}/libshared/common.h
  ${SOURCE_DIR}/libshared/libshared.h
  ${SOURCE_DIR}/libshared/libshared.cpp
)

add_library(libshared SHARED ${shared_files})  # 添加一个动态库 libshared , 使用 shared_files 的文件

target_include_directories(libshared PUBLIC ${SOURCE_DIR}/libshared)  # libstatic 添加 include 目录 , PUBLIC 表示 包含libstatic库的其他库或者进程也include这个目录
                                                                      # 也可使用 PRIVATE 表示 只这个库使用,包含libstatic库的,不include这个目录


target_compile_definitions(libshared PUBLIC LIBSHARED)                # 添加宏定义 , PUBLIC 表示 包含这个libstatic库的其他库或者进程也有这个宏定义
                                                                      # 也可使用 PRIVATE 表示 只这个库使用,包含这个库的,没有这个宏定义

if(MSVC)
  target_compile_definitions(libshared
        PUBLIC  USE_DLLS
        PRIVATE LIB_EXPORTS)
endif()


set_target_properties(libshared PROPERTIES
    OUTPUT_NAME ${LIB_PREFIX}libshared
    DEBUG_POSTFIX "${DEBUG_POSTFIX}")         # 设置属性,属性列表见 https://cmake.org/cmake/help/v3.8/manual/cmake-properties.7.html#target-properties


############################ 程序 ##################################

  set(progress_files
    ${SOURCE_DIR}/progress/main.cpp
    ${SOURCE_DIR}/progress/progress.h
    ${SOURCE_DIR}/progress/progress.cpp
  )

  add_executable(progress ${progress_files})

  set_target_properties(progress PROPERTIES 
                        DEBUG_POSTFIX "${DEBUG_POSTFIX}")         # 设置属性,属性列表见 https://cmake.org/cmake/help/v3.8/manual/cmake-properties.7.html#target-properties

  target_link_libraries(progress libshared libstatic )  # 添加包含的库



############################ install ##################################

  install(TARGETS libshared libstatic progress
    RUNTIME DESTINATION ${SOURCE_DIR}/build/bin                         # 指定执行程序的安装目录,dll版本的动态库也在这里
    LIBRARY DESTINATION ${SOURCE_DIR}/build/lib                         # 非dll的动态库,放在这里
    ARCHIVE DESTINATION ${SOURCE_DIR}/build/lib/static                  # 静态库放在这里,dll的lib也在这里
                                                                  # 指定相对路径,会按照默认的路径按照 
                                                                  # linux 默认位置 /usr/local  , windows 默认位置 c:/Program Files/${PROJECT_NAME}
    )

