package at.klausbetz.provider;

import org.jboss.logging.Logger;

import java.io.IOException;

final class Retry {

    private static final Logger logger = Logger.getLogger(Retry.class);

    @FunctionalInterface
    interface IOSupplier<T> {
        T get() throws IOException;
    }

    private Retry() {
    }

    static <T> T withRetry(IOSupplier<T> action, int attempts) throws IOException {
        IOException lastFailure = null;
        for (int attempt = 1; attempt <= attempts; attempt++) {
            try {
                return action.get();
            } catch (IOException e) {
                lastFailure = e;
                logger.warnf("Apple token request failed (attempt %d/%d): %s", attempt, attempts, e.getMessage());
            }
        }
        throw lastFailure;
    }
}
