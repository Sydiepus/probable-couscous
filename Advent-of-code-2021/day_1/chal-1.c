#include <stdio.h>
#include <stdlib.h>

int main(){
    //it's a pain to dynamically allocate array put the numbers of lines you have.
    const int lines = 2000;
    int num, increased = 0, sum_increased = 0;
    FILE *file;
    //open the file.
    file = fopen("/input.txt", "r");
    //check for errors when opening the file.
    if (file == NULL){
        printf("Error opening the file");
        exit(1);
    };
    //create array and add number to it.
    int num_arr[lines];
    int j = 0;
    while (fscanf(file, "%d", &num) != EOF){
        num_arr[j] = num;
        j++;
    }
    //check how many numbers have increased. (part 1)
    for (int i = 1; i < lines; i++){
        if (num_arr[i] > num_arr[i - 1]){
            increased++;
        }
    }

    //part 2
    //create a new array for the sum and then check it for increases.
    int sum_arr[lines];
    for (int i = 1; i < lines; i++){
        if ((i + 2) == lines){
            sum_arr[i] = num_arr[i] + num_arr[i + 1] + num_arr[i + 2];
            break;
        }
        sum_arr[i] = num_arr[i] + num_arr[i + 1] + num_arr[i + 2];
    }
    for (int i = 1; i < lines; i++){
        if (sum_arr[i] > sum_arr[i - 1]){
            sum_increased++;
        }
    }

    printf("part 1 increased = %d\n", increased);
    printf("part 2 increased = %d\n", sum_increased);
    fclose(file);
    return 0;
}