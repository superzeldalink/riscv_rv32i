/* Type your code here, or load an example. */

#define ROW1 3 // Number of rows in the first matrix
#define COL1 3 // Number of columns in the first matrix
#define ROW2 3 // Number of rows in the second matrix
#define COL2 3 // Number of columns in the second matrix

int main() {
    int matrix1[ROW1][COL1] = {{1, 2, 3},
                               {4, 5, 6},
                               {7, 8, 9}};

    int matrix2[ROW2][COL2] = {{9, 8, 7},
                               {6, 5, 4},
                               {3, 2, 1}};

    int resultMatrix[ROW1][COL2]; // To store the result

    // Multiply matrix1 and matrix2
    multiplyMatrices(matrix1, matrix2, resultMatrix);

    int sum = 0;
    for (int i = 0; i < ROW1; ++i) {
        for (int j = 0; j < COL2; ++j) {
            sum += resultMatrix[i][j];
        }
    }

    int* LEDR;
    int* BCD_in;
    int* BCD_out;
    int* HEX2HEX;
    LEDR = (int*)0x880;
    BCD_in = (int*)0xA00;
    BCD_out = (int*)0xA04;
    HEX2HEX = (int*)0x8B0;

    *BCD_in = sum;
    *HEX2HEX = *BCD_out;

    *LEDR = sum;

    while(1);
}


int multiply(int a, int b) {
    int result = 0;
    for(int i = 0; i < b; i++) {
        result += a;
    }
    return result;
}

void multiplyMatrices(int mat1[ROW1][COL1], int mat2[ROW2][COL2], int result[ROW1][COL2]) {
    int i, j, k;

    // Initialize the result matrix with zeros
    for (i = 0; i < ROW1; ++i) {
        for (j = 0; j < COL2; ++j) {
            result[i][j] = 0;
        }
    }

    // Perform matrix multiplication
    for (i = 0; i < ROW1; ++i) {
        for (j = 0; j < COL2; ++j) {
            for (k = 0; k < COL1; ++k) {
                result[i][j] += multiply(mat1[i][k], mat2[k][j]);
            }
        }
    }
}
