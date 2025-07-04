use std::env;
use std::time::Instant;
use std::hint::black_box;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 { return; }
    let n: usize = args[1].parse().unwrap();
    let mut is_prime = vec![true; n + 1];
    let start = Instant::now();
    let mut p = 2usize;
    while p * p <= n {
        if is_prime[p] {
            let mut j = p * p;
            while j <= n {
                is_prime[j] = false;
                j += p;
            }
        }
        p += 1;
    }
    let count = (2..=n).filter(|&i| is_prime[i]).count();
    let elapsed = start.elapsed().as_secs_f64();
    black_box(count);
    println!("primes={} time={:.6}", count, elapsed);
}
