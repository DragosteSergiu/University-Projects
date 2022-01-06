package runners;

import model.Matrix;
import utils.TaskType;
import utils.Utils;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import utils.TaskType.*;

public class ThreadPoolRunner {
    public static void run(Matrix matrix1, Matrix matrix2, Matrix resultMatrix, int noOfThreads, TaskType taskType) throws Exception {
        ExecutorService executorService= Executors.newFixedThreadPool(noOfThreads);

        if (taskType.equals(TaskType.ROW)){
            for (int i = 0; i < noOfThreads; i++)
                executorService.submit(Utils.initializeRowComputationThread(i, matrix1, matrix2, resultMatrix, noOfThreads));
        }
        if (taskType.equals(TaskType.COLUMN)){
            for (int i = 0; i < noOfThreads; i++)
                executorService.submit(Utils.initializeColumnComputationThread(i, matrix1, matrix2, resultMatrix, noOfThreads));
        }
        if (taskType.equals(TaskType.KTH)){
            for (int i = 0; i < noOfThreads; i++)
                executorService.submit(Utils.initializeKthElementComputationThread(i, matrix1, matrix2, resultMatrix, noOfThreads));
        }
        executorService.shutdown();
        try{
            if(executorService.awaitTermination(500, TimeUnit.SECONDS)){
                executorService.shutdownNow();
            }
            System.out.println("Final result is:\n" + resultMatrix.toString());
        }catch (InterruptedException e){
            executorService.shutdownNow();
            e.printStackTrace();
            Thread.currentThread().interrupt();
        }


    }
}

