############################ 注释 ##################################

# "#"注释开始
#[[
	这样是多行注释
]]


############################ 提示信息 ##################################
message("message1")

# 提示消息可以指定类型
# 下面是具体类型
# STATUS         = Incidental information
# WARNING        = CMake Warning, continue processing
# AUTHOR_WARNING = CMake Warning (dev), continue processing
# SEND_ERROR     = CMake Error, continue processing,
#                              but skip generation
# FATAL_ERROR    = CMake Error, stop processing and generation
# DEPRECATION    = CMake Deprecation Error or Warning if variable
#                 CMAKE_ERROR_DEPRECATED or CMAKE_WARN_DEPRECATED
#                is enabled, respectively, else no message.

message( STATUS "message" "STATUS 1") # 字符串可以多个
									# 函数的参数用空格隔开 

message( STATUS "message" # 也可以换行
				"STATUS 2"
		)									


############################ 变量 ##################################

# 不区分大小写 !!!!!

# 用set函数 设置变量的值
set( variable_name variable_value )

message("variable:" ${variable_name})	# ${variable_name} 取变量的值

message("variable:" ${variable_name}additional_message)	# ${variable_name} 可直接组合字符串

# 变量类型
#BOOL
#	Boolean ON/OFF value. cmake-gui(1) offers a checkbox.
#FILEPATH
#	Path to a file on disk. cmake-gui(1) offers a file dialog.
#PATH
#	Path to a directory on disk. cmake-gui(1) offers a file dialog.
#STRING
#	A line of text. cmake-gui(1) offers a text field or a drop-down selection if the STRINGS cache entry property is set.
#INTERNAL
#	A line of text. cmake-gui(1) does not show internal entries. They may be used to store variables persistently across runs. Use of this type implies FORCE.

set(variable_bool ON)
message("variable_bool:" ${variable_bool})


############################ 列表 lists ##################################

set(list_var a.c b.c c.c) # 以空格隔开

foreach(loop_var ${list_var}) 
	message( ${loop_var})	# a.c b.c c.c
endforeach(loop_var)


############################ 判断语句 ##################################

# 判断操作符:
# EXISTS, COMMAND, DEFINED
# EQUAL, LESS, LESS_EQUAL, ``GREATER, GREATER_EQUAL, STREQUAL, STRLESS, STRLESS_EQUAL, 
# STRGREATER, STRGREATER_EQUAL, VERSION_EQUAL, VERSION_LESS, VERSION_LESS_EQUAL, 
# VERSION_GREATER, VERSION_GREATER_EQUAL, MATCHES
# 详情见 https://cmake.org/cmake/help/v3.8/command/if.html#command:if

set(predicate1 OFF)
set(predicate2 OFF)
set(predicate3 OFF)

set(predicate_value1 1)
set(predicate_value2 2)

# if 格式
if(predicate1)
	message("predicate1")
elseif(predicate2)
	message("predicate2")
elseif(predicate_value1 EQUAL predicate_value2 )
else(predicate3)				# 这个predicate3在else中其实没啥效果
	message("predicate3")
endif(predicate1) # 与if的值一样


############################ 循环语句 ##################################

# foreach
foreach(loop_var 1 3) 
	message( ${loop_var})	# loop1 loop3
endforeach(loop_var)

foreach(loop_var RANGE 10) # 0-10的循环
	message(${loop_var}) # loop0 至 loop10
endforeach(loop_var)

foreach(loop_var RANGE 1 10 2)
	message(${loop_var}) # loop1 loop3 loop5 loop7 loop9
endforeach(loop_var)

# while
set(while_predicate 1)
while(while_predicate LESS 10)
	
	message(while${while_predicate})
	
	set(while_predicate while_predicate+1)

	if(while_predicate EQUAL 4)
		 continue()
	endif(while_predicate EQUAL 4)
	
	if(while_predicate EQUAL 5)
		 break()
	endif(while_predicate EQUAL 5)

endwhile(while_predicate LESS 10)	# 需要与 while判断的一样




############################ 函数 ##################################


function(function_name param_name1 param_name2 param_name3)
	message( ${param_name1}) 
	message( ${param_name2})
	message( ${param_name3})

	message( ${ARGC})  # ARGC 参数数量
	foreach(arg IN LISTS ARGV) # ARGV 参数lists
    	message(${arg})
  	endforeach()

	# message( ${ARGV0}) # ARGV0, ARGV1, ARGV2, ...

	set(${func_param} 2) # 已这种方式修改外部变量
endfunction(function_name)

set(func_param 1)

function_name(func_param 2 3)

message(${func_param})


############################ 宏 ##################################

macro(_MACRO_NAME macro_arg1 macro_arg2)
  set(list_var ARGV)
  foreach(arg IN LISTS ${ARGV})
    message(${arg})
  endforeach()
endmacro(_MACRO_NAME)

message("macro")

set(a 1)
set(b 2)
_macro_name(a b)


