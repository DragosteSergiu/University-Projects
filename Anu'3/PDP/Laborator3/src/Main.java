import model.Matrix;
import runners.BasicThreadRunner;
import runners.ThreadPoolRunner;
import utils.Approach;
import utils.TaskType;

public class Main {
    private static final int FIRST_MATRIX_NR_OF_ROWS=5;
    private static final int FIRST_MATRIX_NR_OF_COLS=5;
    private static final int SECOND_MATRIX_NR_OF_ROWS=5;
    private static final int SECOND_MATRIX_NR_OF_COLS=5;

    private static final int NO_OF_THREADS=2;
    private static final TaskType TASK_TYPE=TaskType.KTH;
    private static final Approach APPROACH=Approach.THREAD_POOL;

    public static void main(String[] args) {
        // initializes the 2 matrices
        Matrix matrix1=new Matrix(FIRST_MATRIX_NR_OF_ROWS,FIRST_MATRIX_NR_OF_COLS);
        Matrix matrix2=new Matrix(SECOND_MATRIX_NR_OF_ROWS,SECOND_MATRIX_NR_OF_COLS);

        // randomly populates the 2 matrices
        matrix1.randomlyPopulateMatrix();
        matrix2.randomlyPopulateMatrix();

        // displays the 2 matrices
        System.out.println("Matrix1:");
        System.out.println(matrix1);
        System.out.println("Matrix2:");
        System.out.println(matrix2);

        if(matrix1.nrCols==matrix2.nrRows){
            Matrix resultMatrix=new Matrix(matrix1.nrRows,matrix2.nrCols);

            long start = System.currentTimeMillis();

            if(APPROACH.equals(Approach.BASIC)){
                try{
                    BasicThreadRunner.run(matrix1,matrix2,resultMatrix,NO_OF_THREADS,TASK_TYPE);
                }
                catch(Exception e){
                    e.printStackTrace();
                }
            }
            else{
                try{
                    ThreadPoolRunner.run(matrix1,matrix2,resultMatrix,NO_OF_THREADS,TASK_TYPE);
                }
                catch(Exception e){
                    e.printStackTrace();
                }
            }

            long end = System.currentTimeMillis();
            System.out.println("Time elapsed is: "+(float)(end-start)/1000 +" seconds");
        }
        else
            System.out.println("The multiplication of the 2 matrices is impossible since the nr of cols of the first one must be equal to the nr of rows of the second one!");
    }

}
