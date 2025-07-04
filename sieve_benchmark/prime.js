const n = parseInt(process.argv[2]);
if (!n) process.exit(1);
const isPrime = Array(n + 1).fill(true);
const start = process.hrtime.bigint();
for (let p = 2; p * p <= n; p++) {
  if (isPrime[p]) {
    for (let j = p * p; j <= n; j += p) {
      isPrime[j] = false;
    }
  }
}
let count = 0;
for (let i = 2; i <= n; i++) {
  if (isPrime[i]) count++;
}
const end = process.hrtime.bigint();
const elapsed = Number(end - start) / 1e9;
console.log(`primes=${count} time=${elapsed.toFixed(6)}`);
