package runners;

import model.Matrix;
import utils.TaskType;
import utils.Utils;

import java.util.ArrayList;
import java.util.List;

public class BasicThreadRunner {
    public static void run(Matrix matrix1, Matrix matrix2, Matrix resultMatrix, int noOfThreads, TaskType taskType) throws Exception{
        List<Thread> threads=new ArrayList<>();

        if (taskType.equals(TaskType.ROW)){
            for (int i = 0; i < noOfThreads; i++)
                threads.add(Utils.initializeRowComputationThread(i, matrix1, matrix2, resultMatrix, noOfThreads));
        }
        if (taskType.equals(TaskType.COLUMN)){
            for (int i = 0; i < noOfThreads; i++)
                threads.add(Utils.initializeColumnComputationThread(i, matrix1, matrix2, resultMatrix, noOfThreads));
        }
        if (taskType.equals(TaskType.KTH)){
            for (int i = 0; i < noOfThreads; i++)
                threads.add(Utils.initializeKthElementComputationThread(i, matrix1, matrix2, resultMatrix, noOfThreads));
        }

        for (Thread thread : threads) {
            thread.start();
        }
        for (Thread thread : threads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        System.out.println("Final result is:\n" + resultMatrix.toString());
    }
}
