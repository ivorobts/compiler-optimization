/* ========================================================================== *
!*
!* SAMPLE SOURCE CODE - SUBJECT TO THE TERMS OF SAMPLE CODE LICENSE AGREEMENT,
!* http://software.intel.com/en-us/articles/intel-sample-source-code-license-agreement/
!*
!* Copyright 2010-2018 Intel Corporation
!*
!* THIS FILE IS PROVIDED "AS IS" WITH NO WARRANTIES, EXPRESS OR IMPLIED,
!* INCLUDING BUT NOT LIMITED TO ANY IMPLIED WARRANTY OF MERCHANTABILITY,
!* FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT OF INTELLECTUAL
!* PROPERTY RIGHTS.
!*
!* ========================================================================== */

#include <stdio.h>
#include <math.h>
#include <malloc.h>
#ifdef __linux__
#include <sys/time.h>
#else
#include <windows.h>
#endif
#include "multiply.h"

// Timer implementation
#ifdef __linux__
static struct timeval tstart, tstop;
#else
static FILETIME tstart, tstop;
#endif
void start_timer()
{
#ifdef __linux__
    gettimeofday(&tstart, NULL);
#else
    GetSystemTimeAsFileTime(&tstart);
#endif
}

double stop_timer()
{
#ifdef __linux__
    gettimeofday(&tstop, NULL);
    return (tstop.tv_sec + tstop.tv_usec / 1000000.0) -
           (tstart.tv_sec + tstart.tv_usec / 1000000.0);
#else
    GetSystemTimeAsFileTime(&tstop);
    return (double)(tstop.dwLowDateTime - tstart.dwLowDateTime) / 10000000;
#endif
}

// Initialize matrix
void init_matrix(int row, int col, FTYPE off, FTYPE  a[][COLWIDTH])
{
    int i,j;

    for (i = 0; i < row; i++) {
        for (j = 0; j < col; j++) {
            a[i][j] = fmod(i * j + off, 10.0);
        }
    }

    if (COLBUF > 0) // optional padding
        for  (i = 0; i < row; i++)
            for (j = col; j < COLWIDTH; j++)
                a[i][j] = 0.0;
}

// Initialize vector
void init_vector(int length, FTYPE off, FTYPE a[])
{
    int i;

    for (i = 0; i < length; i++)
        a[i] = fmod(i + off, 10.0);

    if (COLBUF > 0) // optional padding
        for  (i = length; i < COLWIDTH; i++)
            a[i] = 0.0;
}

// Print the sum of the first "length" elements of "vec"
// (needed to verify correctness of different versions)
void printsum(int length, FTYPE vec[]) {
    int i;
    FTYPE sum=0.0;

    for (i=0; i<length; i++) sum += vec[i];

    printf("Sum of result = %f\n", sum);
}

// For multiply.c; defined here to simulate what happens if loop strides are not
// known during compilation time.
unsigned int inc_i = 1;
unsigned int inc_j = 1;

int main(int argc, char **argv)
{
    int i;
    double duration = 0.0;

    FTYPE a[ROW][COLWIDTH];
    FTYPE b[ROW] = { 0.0 };
	FTYPE c[ROW] = { 0.0 };
    FTYPE x[COLWIDTH];

    printf("ROW: %d COL: %d\n", ROW, COL);

    // Initialize matrix & vector
    init_matrix(ROW, COL, 1.0, a);
    init_vector(COL, 3.0, x);

    // Do the measurement
    start_timer();
    for (i = 0; i < REPEATNTIMES; i++) {
        matvec(ROW, COLWIDTH, a, b, x, c);
    }
    duration = stop_timer();

    // Print results
    printf("Elapsed time = %lf seconds\n", duration);
    printf("GigaFlops = %f\n", (((double)REPEATNTIMES *
                                 (double)ROW * (double)COLWIDTH * 2.0) /
                                 duration) / 1000000000.0);
    printsum(ROW, b);

    return 0;
}
