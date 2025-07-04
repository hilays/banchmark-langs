#!/bin/bash
set -e
N=${1:-10000000}
cd "$(dirname "$0")"
rm -f results.txt

run() {
  local lang=$1
  shift
  echo "=== $lang ===" >> results.txt
  /usr/bin/time -v "$@" $N >> results.txt 2>&1
  echo >> results.txt
}

gcc prime.c -O2 -o prime_c
run "C" ./prime_c

g++ prime.cpp -O2 -o prime_cpp
run "C++" ./prime_cpp

rustc -C opt-level=3 prime.rs -o prime_rs
run "Rust" ./prime_rs

go build -o prime_go prime.go
run "Go" ./prime_go

run "Python" python3 prime.py

javac Prime.java
run "Java" java Prime

run "Node" node prime.js
