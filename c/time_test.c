#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <x86intrin.h>

int main(int argc, char *argv[]) {
    long long n = 1000000;
    if (argc > 1) {
        n = atoll(argv[1]);
    }
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
    printf("sum=%lld dummy=%lld cycles=%llu\n", sum_len, dummy, end - start);
    return 0;
}
