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

subroutine matvec(rows, cols, a, b, x)
    use Global ! inc_i & inc_j
    implicit none
    integer rows, cols, i, j
    real*8, contiguous :: a(:,:), b(:), x(:)

    do i = 1, cols, inc_i
        b(i) = sum(a(1:rows:inc_j, i) * x(1:rows:inc_j))
    enddo
end subroutine
