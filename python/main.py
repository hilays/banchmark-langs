import sys
import time


def cpu_freq():
    try:
        with open('/proc/cpuinfo') as f:
            for line in f:
                if line.startswith('cpu MHz'):
                    return float(line.split(':')[1]) * 1e6
    except FileNotFoundError:
        pass
    return 1e9


n = int(sys.argv[1]) if len(sys.argv) > 1 else 1_000_000
freq = cpu_freq()
start = time.perf_counter()
sum_len = 0
dummy = 0
for i in range(n):
    x = i * 3 + 7
    x = (x ^ (x << 2)) + (x >> 3)
    s = str(x)
    sum_len += len(s)
    dummy += x
elapsed = time.perf_counter() - start
cycles = int(elapsed * freq)
print(f"sum={sum_len} dummy={dummy} cycles={cycles}")
