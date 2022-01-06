import java.util.*;

import java.util.Timer;
import java.util.TimerTask;

public class Main {

    public static void initialize(Node... nodes){
        nodes[2].setParent(nodes[4]);
        nodes[0].setParent(nodes[3]);
        nodes[1].setParent(nodes[3]);
        nodes[3].setParent(nodes[4]);
    }

    public static void update(Integer position, Node[] nodes){
        int i = 0;
        for(Node node: nodes){
            if (i != position){
                node.setOldValue(node.getValue());
            }
            i += 1;
        }
    }

    public static void execute(ConsistencyChecker consistencyChecker, Node... nodes) throws InterruptedException {
        Random rand = new Random();
        new Thread(new Runnable() {
            @Override
            public void run() {
                Integer i = 1;
                while (i < 100) {
                    try {
                        Thread.sleep(500);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    Integer position = rand.nextInt(3);
                    Integer value = rand.nextInt(100);
                    System.out.println("Primary 1 + Primary 2 = Secondary 1(" + nodes[0].getValue().toString() + " + " + nodes[1].getValue().toString() + " = " + nodes[3].getValue().toString() + "), Primary 3 + Secondary 1 = Secondary 2(" + nodes[2].getValue().toString() + " + " + nodes[3].getValue().toString() + " = " + nodes[4].getValue().toString() +")");
                    System.out.println("Step " + i.toString() + ": Modify node on position " + position.toString() + ", value " + nodes[position].getValue().toString() + " is changed into " + value.toString());
                    nodes[position].modifyValue(value);
                    update(position, nodes);
                    i += 2;
                }
            }
        }).start();

        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                Integer i = 2;
                while (i < 100) {
                    try {
                        Thread.sleep(500);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    Integer position2 = rand.nextInt(3);
                    Integer value2 = rand.nextInt(100);
                    System.out.println("Primary 1 + Primary 2 = Secondary 1(" + nodes[0].getValue().toString() + " + " + nodes[1].getValue().toString() + " = " + nodes[3].getValue().toString() + "), Primary 3 + Secondary 1 = Secondary 2(" + nodes[2].getValue().toString() + " + " + nodes[3].getValue().toString() + " = " + nodes[4].getValue().toString() +")");
                    System.out.println("Step " + i.toString() + ": Modify node on position " + position2.toString() + ", value " + nodes[position2].getValue().toString() + " is changed into " + value2.toString());
                    nodes[position2].modifyValue(value2);
                    update(position2, nodes);
                    i += 2;
                }
            }
        }).start();

        new Thread(new Runnable() {
            @Override
            public void run() {
                Integer i = 1;
                while (i < 10){
                    try {
                        Thread.sleep(5000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    consistencyChecker.run();
                    i += 1;
                }
            }
        }).start();

    }


    public static void main(String[] args) {
        Node primary3 = new Node(4, null);
        Node primary1 = new Node(2, null);
        Node primary2 = new Node(5, null);
        Node secondary1 = new Node(primary1.getValue() + primary2.getValue(), null);
        Node secondary2 = new Node(primary3.getValue() + secondary1.getValue(), null);
        initialize(primary1, primary2, primary3, secondary1, secondary2);
        ConsistencyChecker consistencyChecker = new ConsistencyChecker(primary1, primary2, primary3, secondary1, secondary2);
        try {
            execute(consistencyChecker, primary1, primary2, primary3, secondary1, secondary2);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}