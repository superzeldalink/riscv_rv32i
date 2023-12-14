#define ARRAY_SIZE 100
int rand_state;

int rand(void);
int multiply(int a, int b);
void merge(int arr[], int l, int m, int r);
void mergeSort(int arr[], int l, int r);

int main() {
    int temp;
    int* array;
    array = (int*)0x10000000;
    for(int i = 0; i < ARRAY_SIZE; i++){
        array[i] = rand();
    }
    for(int i = 0; i < ARRAY_SIZE; i++){
        temp = array[i]; 
        array[i] = multiply(temp, rand());
    }

    mergeSort(array, 0, ARRAY_SIZE - 1);

    int* output_addr;
    output_addr = (int*)0x880;
    *output_addr = 0x1;

    while(1);
}
int rand(void) {
    rand_state = (rand_state * 1103515245 + 12345) & 0x7fffffff;
    return rand_state;
}

int multiply(int a, int b) {
    int result = 0;
    for(int i = 0; i < b; i++) {
        result += a;
    }
    return result;
}

void merge(int arr[], int l, int m, int r) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;
 
    // Create temp arrays
    int L[n1], R[n2];
 
    // Copy data to temp arrays L[] and R[]
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];
 
    // Merge the temp arrays back into arr[l..r
    i = 0;
    j = 0;
    k = l;
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
 
    // Copy the remaining elements of L[],
    // if there are any
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }
 
    // Copy the remaining elements of R[],
    // if there are any
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

void mergeSort(int arr[], int l, int r) {
    if (l < r) {
        int m = l + (r - l) / 2;
 
        // Sort first and second halves
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
 
        merge(arr, l, m, r);
    }
}