package tasks;

import utils.Pair;
import model.Matrix;

public class ComputeKthElementTask extends Task{
    public ComputeKthElementTask(int iStart, int jStart, int taskSize, Matrix matrix1, Matrix matrix2, Matrix resultMatrix,int k) {
        super(iStart, jStart, taskSize, matrix1, matrix2, resultMatrix,k);

    }

    @Override
    public void computeCoordinatesOfElements() {
        int i = iStart;
        int j = jStart;
        int size = taskSize;
        while (size > 0 && i < resultMatrix.nrRows) {
            this.coordinates.add(new Pair<>(i, j));
            size--;
            i += (j + k) / resultMatrix.nrCols;
            j = (j + k) % resultMatrix.nrCols;
        }
    }
}
