import sys
import time

def sieve(n: int) -> int:
    is_prime = [True] * (n + 1)
    for i in range(2, int(n ** 0.5) + 1):
        if is_prime[i]:
            for j in range(i * i, n + 1, i):
                is_prime[j] = False
    return sum(1 for i in range(2, n + 1) if is_prime[i])

def main():
    if len(sys.argv) < 2:
        return
    n = int(sys.argv[1])
    start = time.time()
    count = sieve(n)
    elapsed = time.time() - start
    print(f"primes={count} time={elapsed:.6f}")

if __name__ == "__main__":
    main()
