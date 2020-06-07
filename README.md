This is a simple compiler optimization hands-on exercise to learn some basic compiler optimizations. It uses a simple PI calculation code.

<b>Activity 1 – Base measurements</b>
Compile the code without any optimizations:<br>
<i>icc -O0 pi.c fx.c -o Od_pi_c</i>

<b>Activity 2 – HLO Optimization</b>
Enable the default optimization level and realize a performance gain it gives:<br>
<i>icc -O2 pi.c fx.c -o O2_pi_c</i>

Note that compiling your code with no optimization may be quite useful in some cases, e.g. for debugging and troubleshooting.

<b>Activity 3 – Include IPO</b>
Try one of the powerful compiler optimizations – IPO and use an optimization reports:<br>
<i>icc -O2 -ipo -qopt-report=3 -qopt-report-phase=ipo -qopt-report-file=./ipo-report_c.txt pi.c fx.c -o ipo_pi_c</i>

IPO on single file is not very beneficial in general. However, fot this multi-file build it‘s much better since
there are more opportunities for the compiler to inline and apply other Interprocedural Optimization
techniques. Take a look on optimization report and check what was optimized.

<b>Activity 4 – Use Processor Switches</b>
Compile the example with different SIMD instruction processor extensions(use xSSE4.2, xAVX, xCORE-AVX2, xCORE-AVX512 or xHost options) and IPO. Generate a vectorization report with highest level of details:<br>
<i>icc -ipo -O2 -xHost -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o xhost_pi_c</i>
