This is a simple compiler optimization hands-on exercise to learn some basic compiler optimizations. It uses a simple PI calculation code.

<b>Activity 1 – Base measurements</b>

Compile the code without any optimizations:

icc -O0 pi.c fx.c -o Od_pi_c

Activity 2 – HLO Optimization
*****************************
Enable the default optimization level and realize a performance gain it gives. Note that compiling your code with no optimization may be quite useful in some cases, e.g. for debugging and
troubleshooting.

icc -O2 pi.c fx.c -o O2_pi_c

Activity 3 – Include IPO
************************
Try one of the powerful compiler optimizations – IPO and use an optimization reports.

icc -O2 -ipo -qopt-report=3 -qopt-report-phase=ipo -qopt-report-file=./ipo-report_c.txt pi.c fx.c -o ipo_pi_c

IPO on single file is not very beneficial in general. However, fot this multi-file build it‘s much better since
there are more opportunities for the compiler to inline and apply other Interprocedural Optimization
techniques. Take a look on optimization report and check what was optimized.

