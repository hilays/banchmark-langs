import sys
import time

n = int(sys.argv[1]) if len(sys.argv) > 1 else 10_000_000
start = time.perf_counter()
s = sum(range(n))
elapsed = time.perf_counter() - start
print(f"sum={s} time={elapsed}")
