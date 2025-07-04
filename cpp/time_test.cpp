#include <chrono>
#include <iostream>
#include <x86intrin.h>

int main(int argc, char* argv[]) {
    long long n = 1000000;
    if (argc > 1) {
        n = std::stoll(argv[1]);
    }
    auto wall_start = std::chrono::high_resolution_clock::now();
    unsigned long long start = __rdtsc();
    long long sum_len = 0;
    long long dummy = 0;
    for (long long i = 0; i < n; ++i) {
        long long x = i * 3 + 7;
        x = (x ^ (x << 2)) + (x >> 3);
        std::string s = std::to_string(x);
        sum_len += s.size();
        dummy += x;
    }
    unsigned long long end = __rdtsc();
    auto wall_end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = wall_end - wall_start;
    std::cout << "sum=" << sum_len << " dummy=" << dummy
              << " cycles=" << end - start
              << " time=" << elapsed.count() << std::endl;
    return 0;
}
