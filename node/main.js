const n = process.argv[2] ? parseInt(process.argv[2], 10) : 10000000;
const start = process.hrtime.bigint();
let sum = 0;
for (let i = 0; i < n; i++) {
  sum += i;
}
const end = process.hrtime.bigint();
const elapsed = Number(end - start) / 1e9;
console.log(`sum=${sum} time=${elapsed}`);
