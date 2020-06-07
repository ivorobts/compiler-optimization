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

module Global
    implicit none

    ! For multiply.f90; defined here to simulate what happens if loop strides
    ! are not known during compilation time.
    parameter inc_i = 1
    parameter inc_j = 1

    parameter ROW = 63
    parameter COL = 64
    parameter ROWBUF = 0
    parameter ROWWIDTH = (ROW + ROWBUF)
    parameter REPEATNTIMES = 1000000

    interface
        subroutine matvec(rows, cols, a, b, x)
            integer rows, cols
            real*8, contiguous :: a(:,:), b(:), x(:)
        end subroutine
    end interface

    contains

! Initialize matrix
subroutine init_matrix(row, col, off, a)
    implicit none
    integer row, col, i, j
    real*8 off, a(ROWWIDTH,*)

    do i = 1, col
        do j = 1, row
            a(j, i) = mod((i - 1) * (j - 1) + off, 10.0)
        enddo
    enddo

    if(ROWBUF .gt. 0) then ! optional padding
        do i = 1, col
            do j = row + 1, ROWWIDTH
                a(j, i) = 0.0
            enddo
        enddo
    endif
end subroutine

! Initialize vector
subroutine init_vector(length, off, a)
    implicit none
    integer length, i
    real*8 off, a(*)

    do i = 1, length
        a(i) = mod((i - 1) + off, 10.0)
    enddo

    if(ROWBUF .gt. 0) then ! optional padding
        do i = length + 1, ROWWIDTH
            a(i) = 0.0
        enddo
    endif
end subroutine

! Print the sum of the first "length" elements of "vec"
! (needed to verify correctness of different versions)
subroutine printsum(length, vec)
    implicit none
    integer length, i
    real*8 vec(*), vecsum

    vecsum = 0
    do i = 1, length
        vecsum = vecsum + vec(i)
    enddo

    print *, "Sum of result = ", vecsum
end subroutine
end module

program driver
    use Global
    implicit none

    integer i
    integer starttime, stoptime, rate

    ! Worst case alignment is 64 byte:
    ! 16 byte for SSE, 32 byte for AVX & 64 byte for MIC
!DIR$ ATTRIBUTES ALIGN : 64 :: a, b, x
    real*8, allocatable :: a(:,:), b(:), x(:)

    allocate(a(ROWWIDTH, COL))
    allocate(b(COL))
    allocate(x(ROWWIDTH))

    b = 0.0

    print *,"ROW: ", ROW, " COL: ", COL

    ! Initialize matrix & vector
    call init_matrix(ROW, COL, 1.0D+0, a)
    call init_vector(ROW, 3.0D+0, x)

    ! Do the measurement
    call system_clock(starttime, rate)
    do i = 1, REPEATNTIMES
        call matvec(ROWWIDTH, COL, a, b, x)
    enddo
    call system_clock(stoptime, rate)

    ! Print results
    print *, "Elapsed time = ", (stoptime - starttime) / real(rate), " seconds"
    print *, "GigaFlops = ", ((DBLE(REPEATNTIMES) * ROWWIDTH * COL * 2.0) / &
                              ((stoptime - starttime) / real(rate))) / &
                             1000000000.0
    call printsum(COL, b)
end
