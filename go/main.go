package main

import (
    "fmt"
    "os"
    "strconv"
    "time"
)

func main() {
    n := int64(10000000)
    if len(os.Args) > 1 {
        if val, err := strconv.ParseInt(os.Args[1], 10, 64); err == nil {
            n = val
        }
    }
    start := time.Now()
    sum := int64(0)
    for i := int64(0); i < n; i++ {
        sum += i
    }
    elapsed := time.Since(start).Seconds()
    fmt.Printf("sum=%d time=%f\n", sum, elapsed)
}
