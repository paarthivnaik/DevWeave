cmake_minimum_required(VERSION 3.20)
project(SampleCppApp VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(sample_app src/main.cpp)

enable_testing()
add_executable(sample_tests tests/test_main.cpp)
add_test(NAME SampleTests COMMAND sample_tests)
