#include <cassert>
#include <string>

extern int string_length(const std::string& str);

int main() {
    assert(std::string("DevWeave").length() == 8);
    return 0;
}
