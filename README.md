# Benchmark Languages

This repository provides small CLI programs in multiple languages that
perform an identical, moderately complex workload while measuring both CPU
cycles and wall-clock time consumed.  The programs manipulate integers and strings in a loop so
the compiler cannot optimise the entire computation away.  They are intended
for comparing performance across languages on Linux/WSL.

## Languages Included

- C
- C++
- Rust
- Go
- Python
- JavaScript (Node.js)
- Java

## Installing Compilers/Interpreters

On Ubuntu you can install the required tools with:

```bash
sudo apt-get update
sudo apt-get install build-essential golang rustc cargo python3 nodejs default-jdk
```

## Build and Run

### C

```bash
gcc -O2 c/time_test.c -o c/time_test
./c/time_test 1000000
```

### C++

```bash
g++ -O2 cpp/time_test.cpp -o cpp/time_test
./cpp/time_test 1000000
```

### Rust

```bash
cd rust
cargo build --release
./target/release/rust_app 1000000
```

### Go

```bash
go build -o go/time_test go/main.go
./go/time_test 1000000
```

### Python

```bash
python3 python/main.py 1000000
```

### Node.js

```bash
node node/main.js 1000000
```

### Java

```bash
javac java/TimeTest.java
java -cp java TimeTest 1000000
```

You can change the numeric argument to adjust the workload for your benchmark.

### Run all benchmarks

The helper script `run_benchmarks.py` builds and runs each implementation in
sequence. Provide the desired iteration count as an argument:

```bash
python3 run_benchmarks.py 1000000
```

The script prints the output from each language and writes `results.csv`
containing the cycle counts and execution times.

Generate a PDF report with log-scale charts using:

```bash
python3 generate_report.py
```
