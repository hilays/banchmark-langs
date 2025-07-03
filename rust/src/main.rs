use std::env;
use std::time::Instant;

fn main() {
    let args: Vec<String> = env::args().collect();
    let n: i64 = if args.len() > 1 {
        args[1].parse().unwrap_or(10_000_000)
    } else {
        10_000_000
    };
    let start = Instant::now();
    let mut sum: i64 = 0;
    for i in 0..n {
        sum += i;
    }
    let duration = start.elapsed();
    println!("sum={} time={:.6}", sum, duration.as_secs_f64());
}
