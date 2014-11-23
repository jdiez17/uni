#include "util.h"

void load_file(int8_t* memory, char* file) {
    FILE* fp = fopen(file, "r");

    if (fp == NULL) {
        fprintf(stderr, "Can't open input file.\n");
        exit(1);
    }
  
    int tmp;
    int8_t load_counter;
    while (fscanf(fp, "%d", &tmp) != EOF) {
        memory[load_counter++] = tmp & 0xff;
    }

    if(load_counter % 3 != 0) {
        fprintf(stderr, "Incorrect number of instructions (%d). Expected a multiple of 3.\n", load_counter);
        exit(1);
    }

    TRACE("Loaded %d bytes.\n", load_counter);

    fclose(fp);
}
