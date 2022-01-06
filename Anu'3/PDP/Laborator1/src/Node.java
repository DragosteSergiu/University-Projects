import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;


public class Node{

    private final Lock lock = new ReentrantLock();
    private Integer oldValue;
    private Integer newValue;
    private Node parent;

    public Node(Integer value, Node parent){
        this.oldValue = value;
        this.newValue = value;
        this.parent = parent;
    }

    public Node(Node parent){
        this.parent = parent;
        this.newValue = 0;
        this.oldValue = this.newValue;
    }

    public void modifyValue(Integer value){
        lock.lock();
        try {
            this.setValue(value);

            Integer difference = this.getDifference();
            Node next = this.parent;
            while (next != null){
                next.setValue(next.getOldValue() + difference);
                next = next.getParent();
            }
        }finally {
            lock.unlock();
        }
    }

    public Integer getValue(){
        return this.newValue;
    }
    public void setValue(Integer newValue){
        this.oldValue = this.newValue;
        this.newValue = newValue;
    }

    public Node getParent(){
        return this.parent;
    }
    public void setParent(Node newParent){
        this.parent = newParent;
    }


    public Integer getOldValue(){
        return this.oldValue;
    }
    public void setOldValue(Integer value){
        this.oldValue = value;
    }

    public Integer getDifference(){
        return this.newValue - this.oldValue;
    }


}
