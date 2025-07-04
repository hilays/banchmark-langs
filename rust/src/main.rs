use std::env;
use std::arch::x86_64::_rdtsc;
use std::time::Instant;

fn main() {
    let args: Vec<String> = env::args().collect();
    let n: u64 = if args.len() > 1 {
        args[1].parse().unwrap_or(1_000_000)
    } else {
        1_000_000
    };
    let wall_start = Instant::now();
    let start = unsafe { _rdtsc() };
    let mut sum_len: u64 = 0;
    let mut dummy: u64 = 0;
    for i in 0..n {
        let mut x = i * 3 + 7;
        x = (x ^ (x << 2)) + (x >> 3);
        let s = x.to_string();
        sum_len += s.len() as u64;
        dummy = dummy.wrapping_add(x);
    }
    let end = unsafe { _rdtsc() };
    let elapsed = wall_start.elapsed().as_secs_f64();
    println!("sum={} dummy={} cycles={} time={}", sum_len, dummy, end - start, elapsed);
}
