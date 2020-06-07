/* ========================================================================== *
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
!* ========================================================================== */
#ifndef _MULTIPLY_H_
#define _MULTIPLY_H_
#define ROW 64
#define COL 63
#define COLBUF 0
#define COLWIDTH (COL + COLBUF)
#define REPEATNTIMES 1000000
#define FTYPE double
extern unsigned int inc_i;
extern unsigned int inc_j;

extern void matvec(unsigned int rows, unsigned int cols,
                    FTYPE (*a)[cols], FTYPE *b, FTYPE *x, FTYPE *c);
#endif /* _MULTIPLY_H_ */
