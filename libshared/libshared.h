#pragma once
#include <stdio.h>
#include "common.h"

class LIB_SHARED_API CLibShared
{
public:
  void Test1()
  {
    printf("Shared test 1\n");
  }
  void Test2()
  {
    printf("Shared test 2\n");
  }

private:
  int i;
};

LIB_SHARED_API void TestFunc1();