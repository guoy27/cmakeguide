#pragma once

#ifdef USE_DLLS
	#ifdef LIB_EXPORTS
	#define LIB_SHARED_API __declspec(dllexport)
	#else
	#define LIB_SHARED_API __declspec(dllimport)
	#endif
#else
	#define LIB_SHARED_API  
#endif
