package at.klausbetz.provider;

import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.util.concurrent.atomic.AtomicInteger;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class WithRetryTest {

    @Test
    void succeedsFirstAttempt() throws IOException {
        assertEquals("ok", Retry.withRetry(() -> "ok", 3));
    }

    @Test
    void succeedsAfterTransientFailures() throws IOException {
        AtomicInteger calls = new AtomicInteger();
        String result = Retry.withRetry(() -> {
            if (calls.incrementAndGet() < 3) {
                throw new IOException("appleid.apple.com:443 failed to respond");
            }
            return "ok";
        }, 3);
        assertEquals("ok", result);
        assertEquals(3, calls.get());
    }

    @Test
    void throwsLastFailureWhenExhausted() {
        AtomicInteger calls = new AtomicInteger();
        IOException e = assertThrows(IOException.class, () -> Retry.withRetry(() -> {
            throw new IOException("failure " + calls.incrementAndGet());
        }, 3));
        assertEquals("failure 3", e.getMessage());
        assertEquals(3, calls.get());
    }
}
