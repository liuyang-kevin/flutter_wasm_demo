#include <stdio.h>
#include <emscripten.h>
#include <cstring>
using namespace std;

EMSCRIPTEN_KEEPALIVE
extern "C" int add(int a, int b)
{
  return a + b;
}

EMSCRIPTEN_KEEPALIVE
extern "C" int fib(int n)
{
  if (n <= 0)
  {
    return 0;
  }
  int i, t, a = 0, b = 1;
  for (i = 1; i < n; i++)
  {
    t = a + b;
    a = b;
    b = t;
  }
  return b;
}

EMSCRIPTEN_KEEPALIVE
extern "C" char* version()
{
  char *p=new char[strlen("fWasm_0.0.1")+1]; //strlen(str)只包括可见字符的长度， 不包括/0, 所以要strlen(str)+1
  strcpy(p, "fWasm_0.0.1");
  return p;
}

// int main(int argc, char ** argv) {
//     printf("Hello Worl收到就回多交话费收到就回复复客户快看看d\n");
//     printf("abcqwert %d \n", add(1,2));
//     printf("fib %d\n", fib(6));
// }