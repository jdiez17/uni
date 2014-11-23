#include <stdio.h>
#include <string.h>

void populate_table(int table[], const char* word) {
    int pos = 2;
    int candidate = 0;
    int length = strlen(word);

    table[0] = -1;
    table[1] = 0;

    while(pos < length) {
        if(word[pos - 1] == word[candidate]){
            candidate++;
            table[pos] = candidate;
            pos++;
        } else if(candidate > 0) {
            candidate = table[candidate];
        } else {
            table[pos] = 0;
            pos++;
        }
    }
}

void zero_table(int table[], int length) {
    for(int i = 0; i < length; i++) {
        table[i] = -1;
    }
}

void print_table(int table[], const char* word) {
    int length = strlen(word);

    for(int i = 0; i < length; i++) {
        printf("| %d\t", i);
    }
    printf("| \n");

    for(int i = 0; i < length; i++) {
        printf("| %d\t", table[i]);
    }
    printf("| \n");

    for(int i = 0; i < length; i++) {
        printf("| %c\t", word[i]);
    }
    printf("| \n");
}

int is_substring(const char* a, const char* b, int table[]) {
    int m = 0;
    int i = 0;
    int length_a = strlen(a);
    int length_b = strlen(b);

    while(m + i < length_a) {
        if(b[i] == a[m + i]) { // This iteration matches
            if(i == length_b - 1) // If we are at the end of b, give up
                return m;
            i++;
        } else { // They didn't match, use table[] to backtrack
            if(table[i] > -1) { // If there is an entry in the table, use it
                m += i - table[i];
                i = table[i];
            } else { // Otherwise, reset word pointer and advance text index 
                i = 0;
                m++;
            }
        }
    }

    return length_a;
}

int main(int argc, char** argv) {
    char* a = "dedicated";
    char* b = "cacacatcacacacat";

    int length = strlen(b);
    int table[length];

    populate_table(table, b);
    print_table(table, b);
    //zero_table(table, length);
    //int result = is_substring(a, b, table);
    //printf("is_substring(a, b) = %d\n", result);

    return 0;
}
