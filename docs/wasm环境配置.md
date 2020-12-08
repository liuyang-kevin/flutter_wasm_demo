支持 WebAssembly 的语言

https://github.com/appcypher/awesome-wasm-langs

# wasm
C/C++ 使用 [Emscripten](https://github.com/emscripten-core/emscripten) 这个编译工具，火狐家文档也是这个。
```bash
# mac 上安装，直接brew就行
brew install emscripten -v  # 有几个域名特别慢，加上-v，查看日志，翻墙加白名单
```

# emcc 、em++ 编译命令
等于c的gcc，g++
例如：
```bash
# 编译导出js封装
emcc hello.c -o hello.js
node hello.js hello world
# 直接导出html，网页能用的
emcc export.c -s WASM=1 -o hello.html
```

# cmake 组织项目：
工具 vs code：CMake插件，CmakeTools插件，Live Server 插件

```cmake
cmake_minimum_required(VERSION 3.10)
# toolchain settings
# set(CMAKE_TOOLCHAIN_FILE $ENV{EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)
# emscripten 提供的cmake支持
set(CMAKE_TOOLCHAIN_FILE /usr/local/Cellar/emscripten/2.0.7_1/libexec/cmake/Modules/Platform/Emscripten.cmake)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_COMPILER "em++") # cpp编译器em++
set(CMAKE_C_COMPILER "emcc")  # c编译器emcc

# 你的项目名称
project(cmake-emscripten-explore)
 
file(GLOB_RECURSE WASM_SOURCES  src/*.cpp) # 要添加的源码
add_executable(${PROJECT_NAME} ${WASM_SOURCES})

message("${EMSCRIPTEN_ROOT_PATH}/system/include") # 这个是我从Emscripten.cmake查的 .h头文件路径（#include <emscripten.h>）

target_include_directories(${PROJECT_NAME} PRIVATE src
                                            "${EMSCRIPTEN_ROOT_PATH}/system/include") # 添加头文件

set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "" SUFFIX ".html") # html方式导出
# WASM=1 导出wasm
# EXTRA_EXPORTED_RUNTIME_METHODS='[\"cwrap\"]' 暴露c方法给js
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s WASM=1 -s EXTRA_EXPORTED_RUNTIME_METHODS='[\"cwrap\"]' ")

# $ emcc -O3 -s WASM=1 -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' fib.c

# cmake生成 debug用的，可以注释
execute_process(COMMAND emcc "-v" OUTPUT_VARIABLE OUTING)
message(STATUS "--OUTING--")
```

# 坑：
1. 直接导出带main函数的wasm，直接用 <script async type="text/javascript" src="../../build/cmake-emscripten-explore.js"></script> 就可以运行
2. 导出lib库，方法需要用c方式，不给函数名作混淆
```cpp
#include <emscripten.h>

EMSCRIPTEN_KEEPALIVE
extern "C" int add(int a, int b) // extern "C" 不加这个，add会被符号表重命名
{
  return a + b;
}
```
3. js端单独调用wasm库内方法
```js
<script type="text/javascript" src="../../build/cmake-emscripten-explore.js"></script>
    <script>
    // 需要异步等待wasm的js加载完成。
        Module.onRuntimeInitialized = _ => {
            // Module.cwrap(方法名， 返回类型，【参数。。。】);
            const _add = Module.cwrap('add','number',['number','number']);
            console.log(_add(1,133));

            // emcc其实都默认导出了对应方法，方法名前多了_
            console.log(Module._add(1,3));
            console.log(Module._fib(10));
        };
    </script>
```


# Link
https://emscripten.org/docs/getting_started/Tutorial.html#first-things-first
https://zhuanlan.zhihu.com/p/158586853
https://developers.google.com/web/updates/2018/03/emscripting-a-c-library
https://blog.evernightfireworks.com/emscripten_config/