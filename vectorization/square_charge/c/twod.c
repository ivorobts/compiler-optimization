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
#include <math.h>
#include "square_charge.h"

float twod(
    float x0, float xn,
    float y0, float yn,
    int nx, int ny,
    float xp, float yp)
{
    int j;
    float g, y, sumy = 0.;

    if(ny > 0) {
        g = (yn - y0) / ny;
        sumy = 0.5 * (trap(y0, x0, xn, nx, xp, yp) +
                      trap(yn, x0, xn, nx, xp, yp));

        for(j = 1; j < ny; j++) {
            y = y0 + j * g;
            sumy = sumy + trap(y, x0, xn, nx, xp, yp);
        }
        sumy = sumy * g;
    }
    return sumy;
}
