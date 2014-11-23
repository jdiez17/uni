#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "util.h"

int8_t memory[0x1000];
int8_t pc = 0;

void subleq_write(int8_t addr, int8_t val) {
    if(addr == -1) 
        printf("%c", val);
    else
        memory[addr] = val;
}

void subleq(int8_t a, int8_t b, int8_t c) {
    TRACE("subleq(%d, %d, %d) -> ", a, b, c);

    int8_t result = memory[a] - memory[b];
    subleq_write(b, result);

    TRACE("set %d to %d", b, result);

    if(result <= 0 || b <= 0) {
        pc = c;
        TRACE(", jumping to %d", c);
    } 

    TRACE("\n");
}


int main(int argc, char* argv[]) {
    int cycles = 0;

    if(argc < 2) {
        fprintf(stderr, "Need a file.");
        exit(1);
    }

    load_file(memory, argv[1]);

    while(pc != -1) {
        int8_t a = memory[pc++];
        int8_t b = memory[pc++];
        int8_t c = memory[pc++];

        subleq(a, b, c);

        cycles++;
    }

    TRACE("Exiting after %d cycles.\n", cycles);

    return 0;
}

