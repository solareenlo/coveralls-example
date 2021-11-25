#include <iostream>

int main() {
    int num = 1;

    if ((num % 2) == 0) {
        std::cout << num << " is even." << std::endl;
    } else {
        std::cout << num << " is odd." << std::endl;
    }

    return 0;
}
