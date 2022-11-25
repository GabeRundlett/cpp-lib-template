add_executable(my_test "test.cpp")
target_link_libraries(my_test PRIVATE my_lib::my_lib)
