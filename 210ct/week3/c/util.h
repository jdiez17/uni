#ifndef __UTIL_H
#define __UTIL_H

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define DEBUG 1
#define TRACE(fmt, ...) if(DEBUG) { fprintf(stderr, fmt, ##__VA_ARGS__); }

void load_file(int8_t* memory, char* file);

#endif
