#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <x86intrin.h>
#include <time.h>

int main(int argc, char *argv[]) {
    long long n = 1000000;
    if (argc > 1) {
        n = atoll(argv[1]);
    }
    struct timespec ts_start, ts_end;
    clock_gettime(CLOCK_MONOTONIC, &ts_start);
    unsigned long long start = __rdtsc();
    long long sum_len = 0;
    long long dummy = 0;
    char buf[32];
    for (long long i = 0; i < n; ++i) {
        long long x = i * 3 + 7;
        x = (x ^ (x << 2)) + (x >> 3);
        snprintf(buf, sizeof(buf), "%lld", x);
        sum_len += strlen(buf);
        dummy += x;
    }
    unsigned long long end = __rdtsc();
    clock_gettime(CLOCK_MONOTONIC, &ts_end);
    double elapsed = (ts_end.tv_sec - ts_start.tv_sec) +
                     (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9;
    printf("sum=%lld dummy=%lld cycles=%llu time=%f\n",
           sum_len, dummy, end - start, elapsed);
    return 0;
}
