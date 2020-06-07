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
!DIR$ ASSUME_ALIGNED a:64, b:64, x:64
!DIR$ ASSUME (MOD(rows, 64) .EQ. 0)

    do i = 1, cols, inc_i
!DIR$ VECTOR ALIGNED
        b(i) = sum(mult(a(1:rows:inc_j, i), x(1:rows:inc_j)))
    enddo

    contains
        elemental real*8 function mult(a, x)
            implicit none
            real*8, intent(in) :: a, x
            mult = a * x
        end function
end subroutine
