!* ========================================================================== *
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
!* ========================================================================== *
function trap(y, x0, xn, nx, xp, yp)
    implicit none

    interface
        function rabs(x, y, xp, yp)
            implicit none
            real rabs, x, y, xp, yp
        end function
    end interface

    real trap, y, x0, xn, xp, yp, x, h, sumx
    integer i, nx

    h = (xn - x0) / nx
    sumx = 0.5 * (rabs(x0, y, xp, yp) + rabs(xn, y, xp, yp))

    do i = 1, nx - 1
        x = x0 + i * h
        sumx = sumx + rabs(x, y, xp, yp)
    enddo

    trap = sumx * h
end
