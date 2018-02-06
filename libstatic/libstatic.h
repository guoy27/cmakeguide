#pragma once
#include <stdio.h>

class CStaticLib
{
public:
  CStaticLib();
  ~CStaticLib();

  void Test1()
  {
    printf("Static test 1\n");
  }
  void Test2()
  {
    printf("Static test 2\n");
  }
private:

};
