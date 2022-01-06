package tasks;

import utils.Pair;
import model.Matrix;
import utils.Utils;

import java.util.ArrayList;
import java.util.List;

public abstract class Task extends Thread{
    public List<Pair<Integer,Integer>> coordinates;
    public Matrix matrix1;
    public Matrix matrix2;
    public Matrix resultMatrix;
    public int iStart;
    public int jStart;
    public int taskSize;
    public int k;

    // constructor with k
    public Task(int iStart,int jStart,int taskSize,Matrix matrix1,Matrix matrix2, Matrix resultMatrix,int k ){
        this.iStart=iStart;
        this.jStart=jStart;
        this.taskSize=taskSize;
        this.k=k;
        this.matrix1=matrix1;
        this.matrix2=matrix2;
        this.resultMatrix=resultMatrix;
        this.coordinates=new ArrayList<>();
        computeCoordinatesOfElements();
    }

    // constructor without k
    public Task(int iStart,int jStart,int taskSize,Matrix matrix1,Matrix matrix2, Matrix resultMatrix){
        this.iStart=iStart;
        this.jStart=jStart;
        this.taskSize=taskSize;
        this.matrix1=matrix1;
        this.matrix2=matrix2;
        this.resultMatrix=resultMatrix;
        this.coordinates=new ArrayList<>();
        computeCoordinatesOfElements();
    }

    public abstract void computeCoordinatesOfElements();

    @Override
    public void run() {
        for (Pair<Integer,Integer> coord: this.coordinates){
            int i = coord.getKey();
            int j = coord.getValue();
            try {
                resultMatrix.set(i,j, Utils.computeElementFromPosition(matrix1,matrix2,i,j));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
