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
function twod(x0, xn, y0, yn, nx, ny, xp, yp)
    implicit none

    interface
        function trap(y, x0, xn, nx, xp, yp)
            implicit none
            real trap, y, x0, xn, xp, yp
            integer nx
        end function
    end interface

    real twod, x0, xn, y0, yn, xp, yp, g, y, sumy
    integer nx, ny, j

    twod = 0.

    if(ny .gt. 0) then
        g = (yn - y0) / ny
        sumy = 0.5 * (trap(y0, x0, xn, nx, xp, yp) + &
                      trap(yn, x0, xn, nx, xp, yp))

        do j = 1, ny - 1
            y = y0 + j * g
            sumy = sumy + trap(y, x0, xn, nx, xp, yp)
        enddo
        twod = sumy * g
    endif
end
