package tasks;

import utils.Pair;
import model.Matrix;

public class ComputeColumnsTask extends Task{
    public ComputeColumnsTask(int iStart, int jStart, int taskSize, Matrix matrix1, Matrix matrix2, Matrix resultMatrix) {
        super(iStart, jStart, taskSize, matrix1, matrix2, resultMatrix);

    }

    @Override
    public void computeCoordinatesOfElements() {
        int i = iStart;
        int j = jStart;
        int size = taskSize;
        while (size > 0 &&  i < resultMatrix.nrRows && j < resultMatrix.nrCols) {
            this.coordinates.add(new Pair<>(i, j));
            i++;
            size--;
            if (i == resultMatrix.nrCols) {
                i = 0;
                j++;
            }
        }
    }
}
