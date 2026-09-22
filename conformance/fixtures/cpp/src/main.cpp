#include <iostream>

int string_length(const std::string& str) {
    return static_cast<int>(str.length());
}

int main() {
    std::cout << "DevWeave C++ Sample Running" << std::endl;
    return 0;
}
