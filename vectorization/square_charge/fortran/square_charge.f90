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

! Program to calculate electrostatic potential at a series of points (xp, yp)
! due to a uniform charge distribution over the square with corners (x0, y0)
! and (xn, yn)
program square_charge
    implicit none

    interface
        function twod(x0, xn, y0, yn, nx, ny, xp, yp)
            implicit none
            real twod, x0, xn, y0, yn, xp, yp
            integer nx, ny
        end function
    end interface

    integer i
    parameter x0 = -1., xn = 1., y0 = -1., yn = 1.
    parameter np = 4
    parameter nx = 10000, ny = 10000
    real points(2, np), potential(np)
    integer starttime, stoptime, rate

    data points / -2., 2., 0.5, -3., 6., 8., 1.01, 0.5 /

    call system_clock(starttime, rate)
    do i = 1, np
        potential(i) = twod(x0, xn, y0, yn, nx, ny, points(1, i), points(2, i))
    enddo
    call system_clock(stoptime, rate)

    ! Print results
    print *, "Elapsed time = ", (stoptime - starttime) / real(rate), " seconds"
    print *, "Potentials: ", potential
end
