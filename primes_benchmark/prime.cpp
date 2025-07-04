#include <iostream>
#include <vector>
#include <chrono>
#include <iomanip>

int main(int argc, char* argv[]) {
    if (argc < 2) return 1;
    long n = std::stol(argv[1]);
    std::vector<bool> is_prime(n + 1, true);
    auto start = std::chrono::high_resolution_clock::now();
    for (long p = 2; p * p <= n; ++p) {
        if (is_prime[p]) {
            for (long j = p * p; j <= n; j += p) is_prime[j] = false;
        }
    }
    long count = 0;
    for (long i = 2; i <= n; ++i) if (is_prime[i]) ++count;
    auto end = std::chrono::high_resolution_clock::now();
    double elapsed = std::chrono::duration<double>(end - start).count();
    std::cout << "primes=" << count << " time=" << std::fixed << std::setprecision(6) << elapsed << "\n";
    return 0;
}
