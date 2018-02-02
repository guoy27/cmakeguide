
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


############################ 静态库 ##################################

set(static_files
  ${SOURCE_DIR}/libstatic/libstatic.h
  ${SOURCE_DIR}/libstatic/libstatic.cpp
)

add_library(libstatic STATIC
  ${static_files})
#target_link_libraries(FSCommon ${CMAKE_THREAD_LIBS_INIT})
target_include_directories(libstatic PUBLIC ${SOURCE_DIR}/libstatic)

set_target_properties(commom PROPERTIES
    OUTPUT_NAME ${LIB_PREFIX}commom
    DEBUG_POSTFIX "${DEBUG_POSTFIX}")


if(MSVC AND BUILD_SHARED_LIBS)
  target_compile_definitions(commom
    PUBLIC  USE_DLLS
    PRIVATE LIB_EXPORTS)
endif()

if(BUILD_TEST)
  set(libcommon_test_files
    ${SOURCE_DIR}/common/test/test_libcommon.cpp
  )

  add_executable(test_libcommon ${libcommon_test_files})
  target_link_libraries(test_libcommon commom)

endif()