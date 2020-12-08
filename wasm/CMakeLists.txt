cmake_minimum_required(VERSION 3.10)
# toolchain settings
# set(CMAKE_TOOLCHAIN_FILE $ENV{EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)
set(CMAKE_TOOLCHAIN_FILE /usr/local/Cellar/emscripten/2.0.7_1/libexec/cmake/Modules/Platform/Emscripten.cmake)
message(CMAKE_TOOLCHAIN_FILE)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_COMPILER "em++")
set(CMAKE_C_COMPILER "emcc")


project(cmake-emscripten-explore)
 
file(GLOB_RECURSE WASM_SOURCES  src/*.cpp)
add_executable(${PROJECT_NAME} ${WASM_SOURCES})

message("${EMSCRIPTEN_ROOT_PATH}/system/include")

target_include_directories(${PROJECT_NAME} PRIVATE src
                                            "${EMSCRIPTEN_ROOT_PATH}/system/include")

set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "" SUFFIX ".html")
 
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s WASM=1 -s EXTRA_EXPORTED_RUNTIME_METHODS='[\"cwrap\"]' ")

# $ emcc -O3 -s WASM=1 -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' fib.c

execute_process(COMMAND emcc "-v" OUTPUT_VARIABLE OUTING)
message(STATUS "--OUTING--")