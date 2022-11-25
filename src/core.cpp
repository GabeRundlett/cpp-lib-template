#include <my_lib/my_lib.hpp>
#include <iostream>

namespace my_lib {
    void func() {
        std::cout << "test" << std::endl;

        // This should warn like crazy! Try uncommenting it
        // and enabling static analysis, too.
        //    auto *x = new int{1};
    }
} // namespace my_lib
