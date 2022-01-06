import java.util.LinkedList;
        import java.util.Queue;
        import java.util.concurrent.locks.Condition;
        import java.util.concurrent.locks.Lock;
        import java.util.concurrent.locks.ReentrantLock;

public class InfoTraffic {
    private static final int CAPACITY = 1;
    private final Lock lock = new ReentrantLock();
    private final Condition condition = lock.newCondition();
    private final Queue<Integer> queue = new LinkedList<>();

    public void push(int val) throws InterruptedException {
        lock.lock();
        try {
            while (queue.size() == CAPACITY) {
                System.out.println(Thread.currentThread().getName()
                        + ": Queue is full so I'm gonna wait...");
                condition.await();
            }

            queue.add(val);
            System.out.printf("%s added %d %n", Thread
                    .currentThread().getName(), val);

            condition.signal();

        } finally {
            lock.unlock();
        }
    }

    public int pop() throws InterruptedException {
        lock.lock();
        try {
            while (queue.size() == 0) {
                System.out.println(Thread.currentThread().getName()
                        + ": Queue is empty so I'm gonna wait...");
                condition.await();
            }

            Integer valueGot = queue.poll();
            if (valueGot != null) {
                System.out.printf("%s got %d %n", Thread
                        .currentThread().getName(), valueGot);

                condition.signal();
            }
            return valueGot;
        } finally {
            lock.unlock();
        }
    }
}
