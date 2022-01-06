package model;

import java.util.Random;

public class Matrix {
    public final int nrRows, nrCols;
    public int [][] content;

    public Matrix(int n, int m) {
        this.nrRows = n;
        this.nrCols = m;
        content = new int [n][m];
    }

    public void randomlyPopulateMatrix() {
        Random random = new Random();
        for (int i = 0; i < nrRows; i++) {
            for (int j = 0; j < nrCols; j++) {
                content[i][j] =  1;//random.nextInt(20);
            }

        }
    }

    public int get(int row, int column) {
        return content[row][column];
    }

    public void set(int row, int column, int value) {
        content[row][column] = value;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < nrRows; i++) {
            for (int j = 0; j < nrCols; j++) {
                sb.append(content[i][j]).append(" ");
            }
            sb.append("\n");
        }
        return sb.toString();
    }


}
