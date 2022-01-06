package utils;

import model.Matrix;
import tasks.ComputeColumnsTask;
import tasks.ComputeKthElementTask;
import tasks.ComputeRowsTask;
import tasks.Task;

public class Utils {
    public static int computeElementFromPosition(Matrix matrix1, Matrix matrix2, int rowIndex, int colIndex) throws Exception {
        if (rowIndex<matrix1.nrRows && colIndex<matrix2.nrCols){
            int element = 0;
            for (int k=0;k<matrix1.nrCols;k++){
                element+=matrix1.get(rowIndex,k) * matrix2.get(k,colIndex);
            }
            return element;
        }
        else
            throw new Exception("The given row or column is out of bounds!");
    }

    public static Task initializeRowComputationThread(int taskIndex, Matrix matrix1, Matrix matrix2, Matrix resultMatrix, int noOfThreads) {
        int resultSize = resultMatrix.nrRows * resultMatrix.nrCols;
        int taskSize = resultSize / noOfThreads;

        int iStart = taskSize * taskIndex / resultMatrix.nrRows;
        int jStart = taskSize * taskIndex % resultMatrix.nrRows;

        if (taskIndex == noOfThreads - 1)
            taskSize += resultSize % noOfThreads;

        return new ComputeRowsTask(iStart, jStart, taskSize, matrix1, matrix2, resultMatrix);
    }

    public static Task initializeColumnComputationThread(int taskIndex, Matrix matrix1, Matrix matrix2, Matrix resultMatrix, int noOfThreads) {
        int resultSize = resultMatrix.nrRows * resultMatrix.nrCols;
        int taskSize = resultSize / noOfThreads;

        int iStart = taskSize * taskIndex % resultMatrix.nrRows;
        int jStart = taskSize * taskIndex / resultMatrix.nrRows;

        if (taskIndex == noOfThreads - 1)
            taskSize += resultSize % noOfThreads;

        return new ComputeColumnsTask(iStart, jStart, taskSize, matrix1, matrix2, resultMatrix);
    }

    public static Task initializeKthElementComputationThread(int taskIndex, Matrix matrix1, Matrix matrix2, Matrix resultMatrix, int noOfThreads) {
        int resultSize = resultMatrix.nrRows * resultMatrix.nrCols;
        int taskSize = resultSize/noOfThreads;

        if (taskIndex < resultSize % noOfThreads)
            taskSize++;

        int iStart = taskIndex / resultMatrix.nrRows;
        int jStart = taskIndex % resultMatrix.nrRows;
        return new ComputeKthElementTask(iStart, jStart, taskSize, matrix1, matrix2, resultMatrix, noOfThreads);
    }
}
