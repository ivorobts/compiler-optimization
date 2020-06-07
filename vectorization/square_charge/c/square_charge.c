/* ========================================================================== *
!*
!* SAMPLE SOURCE CODE - SUBJECT TO THE TERMS OF SAMPLE CODE LICENSE AGREEMENT,
!* http://software.intel.com/en-us/articles/
!*        intel-sample-source-code-license-agreement/
!*
!* Copyright 2010-2017 Intel Corporation
!*
!* THIS FILE IS PROVIDED "AS IS" WITH NO WARRANTIES, EXPRESS OR IMPLIED,
!* INCLUDING BUT NOT LIMITED TO ANY IMPLIED WARRANTY OF MERCHANTABILITY,
!* FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT OF INTELLECTUAL
!* PROPERTY RIGHTS.
!*
!* ========================================================================== */
#ifdef __MIC__
#pragma message "You are compiling " __FILE__ " for the coprocessor now!"
#endif

#include <stdio.h>
#ifdef __linux__
#include <sys/time.h>
#else
#include <windows.h>
#endif
#include "square_charge.h"

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

// Program to calculate electrostatic potential at a series of points (xp, yp)
// due to a uniform charge distribution over the square with corners (x0, y0)
// and (xn, yn)
int main(int argc, char **argv)
{
#define NP 4
    int i;
    double duration = 0.0;
    const float x0 = -1., xn = 1., y0 = -1., yn = 1.;
    const int nx = 10000, ny = 10000;
    float potential[NP];
    float xp[NP] = {-2., 0.5, 6., 1.01};
    float yp[NP] = {2., -3.,  8., 0.5 };

    start_timer();
    for (i = 0; i < NP; i++)  {
        potential[i] = twod(x0, xn, y0, yn, nx, ny, xp[i], yp[i]);
    }
    duration = stop_timer();

    // Print results
    printf("Elapsed time = %lf seconds\n", duration);
    printf ("Potentials: %f, %f, %f, %f\n",
            potential[0], potential[1], potential[2], potential[3]);

    return 0;
}
