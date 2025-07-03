public class TimeTest {
    public static void main(String[] args) {
        long n = 10000000;
        if (args.length > 0) {
            try {
                n = Long.parseLong(args[0]);
            } catch (NumberFormatException ignored) {}
        }
        long start = System.nanoTime();
        long sum = 0;
        for (long i = 0; i < n; i++) {
            sum += i;
        }
        double elapsed = (System.nanoTime() - start) / 1_000_000_000.0;
        System.out.println("sum=" + sum + " time=" + elapsed);
    }
}
