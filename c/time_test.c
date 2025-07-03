#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    long long n = 10000000;
    if (argc > 1) {
        n = atoll(argv[1]);
    }
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    long long sum = 0;
    for (long long i = 0; i < n; ++i) {
        sum += i;
    }
    clock_gettime(CLOCK_MONOTONIC, &end);
    double elapsed = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("sum=%lld time=%f\n", sum, elapsed);
    return 0;
}
