const fs = require('fs');

function cpuFreq() {
  try {
    const txt = fs.readFileSync('/proc/cpuinfo', 'utf8');
    const m = txt.match(/cpu MHz\s+:\s+([0-9.]+)/);
    if (m) return parseFloat(m[1]) * 1e6;
  } catch (e) {}
  return 1e9;
}

const n = process.argv[2] ? parseInt(process.argv[2], 10) : 1000000;
const freq = cpuFreq();
const start = process.hrtime.bigint();
let sumLen = 0;
let dummy = 0;
for (let i = 0; i < n; i++) {
  let x = i * 3 + 7;
  x = (x ^ (x << 2)) + (x >> 3);
  const s = String(x);
  sumLen += s.length;
  dummy += x;
}
const elapsedNs = process.hrtime.bigint() - start;
const cycles = Math.round(Number(elapsedNs) * freq / 1e9);
const timeSec = Number(elapsedNs) / 1e9;
console.log(`sum=${sumLen} dummy=${dummy} cycles=${cycles} time=${timeSec}`);
