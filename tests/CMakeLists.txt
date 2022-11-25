add_executable(my-test "test.cpp")
target_link_libraries(my-test PRIVATE my-lib::my-lib)
