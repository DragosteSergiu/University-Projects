import java.util.Arrays;
import java.util.List;


public class ConsistencyChecker{

    private Node[] nodes;
    ConsistencyChecker(Node... nodes){
        this.nodes = nodes;
    }


    public Boolean check(){
        Boolean valid = true;
        if (nodes[0].getValue() + nodes[1].getValue() != nodes[3].getValue()) {
            valid = false;
        }
        if (nodes[2].getValue() + nodes[3].getValue() != nodes[4].getValue()) {
            valid = false;
        }

        return valid;
    }

    public void run(){
        if (this.check() == true){
            System.out.println("Consistency check worked correct !");
        }
        else
        {
            System.out.println("Consistency check failed !");
        }
    }

}
