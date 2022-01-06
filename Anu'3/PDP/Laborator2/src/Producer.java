import java.util.List;

public class Producer extends Thread{
    public InfoTraffic info;
    public List<Integer> vector1, vector2;

    public Producer(InfoTraffic info,List<Integer> vector1, List<Integer> vector2){
        super("Producer");
        this.info = info;
        this.vector1 = vector1;
        this.vector2 = vector2;
    }

    @Override
    public void run() {
        for(int i = 0; i < vector1.size(); i++){
            try{
                System.out.println("Producer -> Consumer: "+ vector1.get(i).toString() + " * " + vector2.get(i).toString() +" = "+ vector1.get(i) * vector2.get(i));
                info.push(vector1.get(i) * vector2.get(i));
            }
            catch(InterruptedException e){
                System.out.println(e.getMessage());
            }
        }
    }
}
