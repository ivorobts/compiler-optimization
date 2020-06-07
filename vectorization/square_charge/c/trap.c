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
#include "square_charge.h"

float trap(float y, float x0, float xn, int nx, float xp, float yp)
{
    int i;
    float x, h, sumx;

    h = (xn - x0) / nx;
    sumx = 0.5 * (rabs(x0, y, xp, yp) + rabs(xn, y, xp, yp));

    for(i = 1; i < nx; i++) {
        x = x0 + i * h;
        sumx += rabs(x, y, xp, yp);
    }
    return sumx * h;
}
