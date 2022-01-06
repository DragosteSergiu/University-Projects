public class Consumer extends Thread{
    public InfoTraffic info;
    public int result = 0;
    public int size;

    public Consumer(InfoTraffic info, int size){
        super("Consumer");
        this.info = info;
        this.size = size;
    }

    @Override
    public void run() {
        for(int i = 0; i < size; i++){
            try{
                Integer value = info.pop();
                System.out.println("Consumer result: " + result + " + " + value + " = " + (result + value));
                result += value;
            }
            catch(InterruptedException e){
                System.out.println(e.getMessage());
            }
        }
    }
}
