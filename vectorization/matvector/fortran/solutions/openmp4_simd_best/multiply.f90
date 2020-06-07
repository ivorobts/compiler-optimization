!* ========================================================================== *
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
!* ========================================================================== *
#ifdef __MIC__
!DIR$ message "You are compiling " __FILE__ " for the coprocessor now!"
#endif

subroutine matvec(rows, cols, a, b, x)
    use Global ! inc_i & inc_j
    implicit none
    integer rows, cols, i, j
    real*8, contiguous :: a(:,:), b(:), x(:)
    real*8 tmp
!DIR$ ASSUME_ALIGNED a:64, b:64, x:64
!DIR$ ASSUME (MOD(rows, 64) .EQ. 0)

    do i = 1, cols, inc_i
        ! Need temporary because OpenMP does not allow references as part of
        ! reduction clauses (yet)!
        tmp = 0.0D+0
!!DIR$ VECTOR ALIGNED
!$OMP SIMD LINEAR(j:inc_j) REDUCTION(+:tmp) ALIGNED(a, b, x:64)
        do j = 1, rows, inc_j
            tmp = tmp + mult(a(j, i), x(j))
        enddo
        b(i) = b(i) + tmp
    enddo

    contains
        real*8 function mult(a, x)
!$OMP DECLARE SIMD(mult) NOTINBRANCH
            implicit none
            real*8, intent(in) :: a, x
            mult = a * x
        end function
end subroutine
