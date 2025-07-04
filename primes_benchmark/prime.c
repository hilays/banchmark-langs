#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    if (argc < 2) return 1;
    long n = atol(argv[1]);
    char *is_prime = calloc(n + 1, sizeof(char));
    if (!is_prime) return 1;
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    for (long i = 2; i <= n; i++) is_prime[i] = 1;
    for (long p = 2; p * p <= n; p++) {
        if (is_prime[p]) {
            for (long j = p * p; j <= n; j += p) is_prime[j] = 0;
        }
    }
    long count = 0;
    for (long i = 2; i <= n; i++) if (is_prime[i]) count++;
    clock_gettime(CLOCK_MONOTONIC, &end);
    double elapsed = (end.tv_sec - start.tv_sec) +
                     (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("primes=%ld time=%.6f\n", count, elapsed);
    free(is_prime);
    return 0;
}
