import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        InfoTraffic info = new InfoTraffic();
        List<Integer> vector1 = new ArrayList<>();
        List<Integer> vector2 = new ArrayList<>();

        for(int i = 1; i <= 10; i++){
            vector1.add(i);
            vector2.add(10 - i + 1);
        }
        Producer producer = new Producer(info, vector1, vector2);
        Consumer consumer = new Consumer(info, vector1.size());

        producer.start();
        consumer.start();
    }
}
