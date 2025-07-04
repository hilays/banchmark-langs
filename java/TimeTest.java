import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class TimeTest {

    private static long cpuFreq() {
        try (BufferedReader br = new BufferedReader(new FileReader("/proc/cpuinfo"))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.startsWith("cpu MHz")) {
                    String[] parts = line.split(":");
                    return (long) (Double.parseDouble(parts[1].trim()) * 1_000_000L);
                }
            }
        } catch (IOException ignored) {
        }
        return 1_000_000_000L;
    }

    public static void main(String[] args) {
        long n = 1_000_000;
        if (args.length > 0) {
            try {
                n = Long.parseLong(args[0]);
            } catch (NumberFormatException ignored) {}
        }
        long freq = cpuFreq();
        long start = System.nanoTime();
        long sumLen = 0;
        long dummy = 0;
        for (long i = 0; i < n; i++) {
            long x = i * 3 + 7;
            x = (x ^ (x << 2)) + (x >> 3);
            String s = Long.toString(x);
            sumLen += s.length();
            dummy += x;
        }
        long elapsedNs = System.nanoTime() - start;
        long cycles = (elapsedNs * freq) / 1_000_000_000L;
        System.out.println("sum=" + sumLen + " dummy=" + dummy + " cycles=" + cycles);
    }
}
