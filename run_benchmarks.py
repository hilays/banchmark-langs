#!/usr/bin/env python3
import subprocess
import sys
import re
from pathlib import Path
import os

ROOT = Path(__file__).resolve().parent

# compile all languages

def run(cmd, cwd=None, env=None):
    result = subprocess.run(cmd, shell=True, cwd=cwd, env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    if result.stdout:
        print(result.stdout)
    return result

def build_all():
    run("gcc -O2 time_test.c -o time_test", cwd=ROOT / 'c')
    run("g++ -O2 time_test.cpp -o time_test", cwd=ROOT / 'cpp')
    run("cargo build --release", cwd=ROOT / 'rust')
    env = os.environ.copy()
    env['CGO_ENABLED'] = '1'
    run("go build -o time_test main.go", cwd=ROOT / 'go', env=env)
    run("javac TimeTest.java", cwd=ROOT / 'java')


def capture_output(cmd, cwd=None):
    result = subprocess.run(cmd, shell=True, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    return result.stdout.strip()


def run_programs(n):
    results = {}
    outputs = {}
    outputs['C'] = capture_output(f"./time_test {n}", cwd=ROOT / 'c')
    outputs['C++'] = capture_output(f"./time_test {n}", cwd=ROOT / 'cpp')
    outputs['Rust'] = capture_output(f"./target/release/rust_app {n}", cwd=ROOT / 'rust')
    outputs['Go'] = capture_output(f"./time_test {n}", cwd=ROOT / 'go')
    outputs['Python'] = capture_output(f"python3 main.py {n}", cwd=ROOT / 'python')
    outputs['Node'] = capture_output(f"node main.js {n}", cwd=ROOT / 'node')
    outputs['Java'] = capture_output(f"java TimeTest {n}", cwd=ROOT / 'java')

    for lang, out in outputs.items():
        m = re.search(r'cycles=([0-9]+)', out)
        results[lang] = m.group(1) if m else 'N/A'
    return results, outputs


def print_table(results):
    print("\nResults:")
    print(f"{'Language':<7} | {'Cycles':>15}")
    print("-" * 24)
    for lang in ['C', 'C++', 'Rust', 'Go', 'Python', 'Node', 'Java']:
        t = results.get(lang, 'N/A')
        print(f"{lang:<7} | {t:>15}")


def main():
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 1000000
    print(f"Building programs...")
    build_all()
    print(f"Running with n={n}...\n")
    results, outputs = run_programs(n)
    for lang, out in outputs.items():
        print(f"{lang}: {out}")
    print_table(results)


if __name__ == '__main__':
    main()
