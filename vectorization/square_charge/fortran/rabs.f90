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
function rabs(x, y, xp, yp)
    implicit none
    real rabs, x, y, xp, yp, absval
    absval = (x - xp) ** 2 + (y - yp) ** 2
    rabs = 1. / sqrt(absval)
end
