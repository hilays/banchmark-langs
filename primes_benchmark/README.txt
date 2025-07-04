Sieve Benchmark Suite
=====================

This directory contains CLI implementations of the Sieve of Eratosthenes in
several languages and scripts to benchmark them on Linux/WSL.

Requirements
------------
Install compilers/interpreters with:

```
sudo apt-get update
sudo apt-get install build-essential g++ gcc python3 default-jdk golang-go rustc nodejs
```

Install Python packages for analysis:

```
pip install pandas matplotlib
```

Building
--------
Compile each implementation using:

```
gcc prime.c -o prime_c
g++ prime.cpp -o prime_cpp
rustc -C opt-level=3 prime.rs -o prime_rs
go build -o prime_go prime.go
javac Prime.java
```

Running the Benchmark
---------------------
Execute all programs with the same upper bound (default 10,000,000):

```
./run_benchmark.sh [N]
```

The script stores output from each run, including `/usr/bin/time -v` statistics,
in `results.txt`.

Analyzing Results
-----------------
Create a summary CSV:

```
python3 summarize_results.py
```

Generate charts:

```
python3 plot_benchmark.py
python3 plot_memory_cpu.py
```

Packaging
---------
To create a tarball of this directory:

```
tar -czf primes_benchmark.tar.gz primes_benchmark
```

The tarball includes all sources, scripts, and this README.
