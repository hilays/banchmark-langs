#!/bin/bash
set -e
N=${1:-10000000}
rm -f results.txt

compile_and_run() {
  local lang=$1
  shift
  echo "=== $lang ===" >> results.txt
  /usr/bin/time -v "$@" $N >> results.txt 2>&1
  echo >> results.txt
}

# C
gcc prime.c -O2 -o prime_c
compile_and_run "C" ./prime_c

# C++
g++ prime.cpp -O2 -o prime_cpp
compile_and_run "C++" ./prime_cpp

# Rust
rustc -C opt-level=3 prime.rs -o prime_rs
compile_and_run "Rust" ./prime_rs

# Go
go build -o prime_go prime.go
compile_and_run "Go" ./prime_go

# Python
compile_and_run "Python" python3 prime.py

# Java
javac Prime.java
compile_and_run "Java" java Prime

# Node
compile_and_run "Node" node prime.js
