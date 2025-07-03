# Benchmark Languages

This repository provides small CLI programs in multiple languages that
perform the same task: summing numbers while measuring execution time.
They are intended for comparing runtime performance on Linux/WSL.

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
./c/time_test 10000000
```

### C++

```bash
g++ -O2 cpp/time_test.cpp -o cpp/time_test
./cpp/time_test 10000000
```

### Rust

```bash
cd rust
cargo build --release
./target/release/rust_app 10000000
```

### Go

```bash
go build -o go/time_test go/main.go
./go/time_test 10000000
```

### Python

```bash
python3 python/main.py 10000000
```

### Node.js

```bash
node node/main.js 10000000
```

### Java

```bash
javac java/TimeTest.java
java -cp java TimeTest 10000000
```

You can change the numeric argument to adjust the workload for your benchmark.
