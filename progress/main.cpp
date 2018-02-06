#include <stdio.h>
#include "libshared.h"
#include "libstatic.h"

int main(int argn, char** argz)
{
  CLibShared libshared;
  libshared.Test1();
  libshared.Test2();
  TestFunc1();

  CStaticLib static_lib;
  static_lib.Test1();
  static_lib.Test2();
}
