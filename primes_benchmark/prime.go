package main

import (
    "fmt"
    "os"
    "strconv"
    "time"
)

func main() {
    if len(os.Args) < 2 {
        return
    }
    n, _ := strconv.Atoi(os.Args[1])
    isPrime := make([]bool, n+1)
    for i := 2; i <= n; i++ {
        isPrime[i] = true
    }
    start := time.Now()
    for p := 2; p*p <= n; p++ {
        if isPrime[p] {
            for j := p * p; j <= n; j += p {
                isPrime[j] = false
            }
        }
    }
    count := 0
    for i := 2; i <= n; i++ {
        if isPrime[i] {
            count++
        }
    }
    elapsed := time.Since(start).Seconds()
    fmt.Printf("primes=%d time=%.6f\n", count, elapsed)
}
