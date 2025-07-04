public class Prime {
    public static void main(String[] args) {
        if (args.length < 1) return;
        int n = Integer.parseInt(args[0]);
        boolean[] isPrime = new boolean[n + 1];
        for (int i = 2; i <= n; i++) isPrime[i] = true;
        long start = System.nanoTime();
        for (int p = 2; p * p <= n; p++) {
            if (isPrime[p]) {
                for (int j = p * p; j <= n; j += p) isPrime[j] = false;
            }
        }
        int count = 0;
        for (int i = 2; i <= n; i++) if (isPrime[i]) count++;
        double elapsed = (System.nanoTime() - start) / 1e9;
        System.out.printf("primes=%d time=%.6f\n", count, elapsed);
    }
}
