This is a simple compiler optimization hands-on exercise to learn some basic icc compiler optimizations. It uses a simple PI calculation code.

<b>Activity 1 – Base measurements</b>
Compile the code without any optimizations:<br>
<i>icc -O0 pi.c fx.c -o Od_pi</i>

<b>Activity 2 – HLO Optimization</b>
Enable the default optimization level and realize a performance gain it gives:<br>
<i>icc -O2 pi.c fx.c -o O2_pi</i>

Note that compiling your code with no optimization may be quite useful in some cases, e.g. for debugging and troubleshooting.

<b>Activity 3 – Include InterProcedural Optimizations(IPO)</b>
Try one of the powerful compiler optimizations – IPO and use an optimization reports:<br>
<i>icc -O2 -ipo -qopt-report=3 -qopt-report-phase=ipo -qopt-report-file=./ipo-report_c.txt pi.c fx.c -o ipo_pi</i>

IPO on single file is not very beneficial in general. However, fot this multi-file build it‘s much better since
there are more opportunities for the compiler to inline and apply other Interprocedural Optimization
techniques. Take a look on optimization report and check what was optimized.

<b>Activity 4 – Use Processor Switches</b>
Compile the example with different SIMD instruction processor extensions(use xSSE4.2, xAVX, xCORE-AVX2, xCORE-AVX512 or xHost options) and IPO. Generate a vectorization report with highest level of details:<br>
<i>icc -ipo -O2 -xHost -qopt-report=5 -qopt-report-phase=vec pi.c fx.c -o xhost_pi</i>
Note that with IPO the optimization reports goes to ipo_out.optrpt by default (if -qopt-report-file option is not set).
Check vectorization report and look for aby issues reported. Do you see a hint on type conversion and division happening inside a loop?

<b>Activity 5 – Use Profile-Guided Optimizations (PGO)</b>
Try a PGO which collects a profile and use the data collected during run time to optimize your code:<br>
<i>icc -prof-gen pi.c fx.c -o pgen_pi<br>
./pgen_pi<br>
icc -O2 -prof-use -ipo pi.c fx.c -o puse_pi</i>

<b>Activity 6 – Auto-parallelization</b>
icc may be able to parallelize your loops automatically using OpenMP. Note that auto-parallelization is
TLP (Thread Level Parallelization) and uses processor cores (and hardware threads) for parallelization of serial
code. However, auto-vectorization is DLP (Data Level Parallelization) and uses wide registers (SSE, AVX, etc.) for
operation of multiple instructions.
Try to auto-parallelize the code by just enabling a compiler option (no source code changes are required):<br>
<i>icc -O2 -parallel -qopt-report:3 -qopt-report-phase=par pi.c fx.c -o par_pi_c</i><br>
Check if this code works faster and open an optimization report to understand what is happening.
Add an IPO option:<br>
<i>icc -O2 -parallel -qopt-report:3 -qopt-report-phase=par pi.c fx.c -o par_pi_c</i>
Note that the time measurement doesn't work correct in that case (need to use OpenMP specific APIs), but you shoud observe a significant speed-up on the system with many cores.

Auto-parallelization doesn’t work for all cases. However, this one is trivial and can be done by
the compiler. Try to parallelize this code yourself. Since it is a simple code add the
OpenMP* parallel for directive before the loop and care about data races. Please add following directive
before for loop in pi.c source file:
#pragma omp parallel for reduction(+:sum) private(x)
Solution is available in pi_par.c. Compile it with no -parallel and -ipo options:<br>
<i>icc -O2 -qopenmp pi_par.c fx.c -o openmp_pi</i>
