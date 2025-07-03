#include <chrono>
#include <iostream>

int main(int argc, char* argv[]) {
    long long n = 10000000;
    if (argc > 1) {
        n = std::stoll(argv[1]);
    }
    auto start = std::chrono::steady_clock::now();
    long long sum = 0;
    for (long long i = 0; i < n; ++i) {
        sum += i;
    }
    auto end = std::chrono::steady_clock::now();
    std::chrono::duration<double> elapsed = end - start;
    std::cout << "sum=" << sum << " time=" << elapsed.count() << std::endl;
    return 0;
}
