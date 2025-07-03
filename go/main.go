package main

/*
#include <x86intrin.h>
unsigned long long read_cycles() { return __rdtsc(); }
*/
import "C"

import (
    "fmt"
    "os"
    "strconv"
)

func main() {
    n := int64(1000000)
    if len(os.Args) > 1 {
        if val, err := strconv.ParseInt(os.Args[1], 10, 64); err == nil {
            n = val
        }
    }
    start := C.read_cycles()
    sumLen := int64(0)
    dummy := int64(0)
    for i := int64(0); i < n; i++ {
        x := i*3 + 7
        x = (x ^ (x << 2)) + (x >> 3)
        s := fmt.Sprintf("%d", x)
        sumLen += int64(len(s))
        dummy += x
    }
    end := C.read_cycles()
    fmt.Printf("sum=%d dummy=%d cycles=%d\n", sumLen, dummy, end-start)
}
