echo "Cleaning executables"
rm *.dpi *.lock *.dyn *.optrpt *_c
echo ...
# Quick Lab
echo "Compiling and running all Quick Lab exercises"
echo ...
echo "icc -O0 pi.c fx.c -o Od_pi_c"
icc -O0 pi.c fx.c -o Od_pi_c
echo ...
echo "icc -O2 pi.c fx.c -o O2_pi_c"
icc -O2 pi.c fx.c -o O2_pi_c
echo ...
echo "icc -O2 -ipo -qopt-report=3 -qopt-report-phase=ipo -qopt-report-file=./ipo-report_c.txt pi.c fx.c -o ipo_pi_c"
icc -O2 -ipo -qopt-report=3 -qopt-report-phase=ipo -qopt-report-file=./ipo-report_c.txt pi.c fx.c -o ipo_pi_c
echo ...
echo "icc -O2 -xHost -qopt-report=5 pi.c fx.c -o ipo_xHoset_pi_c"
icc -O2 -ipo -xHost -qopt-report=5 pi.c fx.c -o ipo_xHost_pi_c
echo ...
echo "icc -prof-gen pi.c fx.c -o pgen_pi_c"
icc -prof-gen pi.c fx.c -o pgen_pi_c
echo ...
echo "Running pgen_pi_c"
./pgen_pi_c
echo ...
echo "icc -O2 -prof-use -ipo pi.c fx.c -o puse_pi_c"
icc -O2 -prof-use -ipo pi.c fx.c -o puse_pi_c
echo ...
echo "icc -O2 -parallel -qopt-report:3 -qopt-report-phase=par pi.c fx.c -o par_pi_c"
icc -O2 -parallel -qopt-report:3 -qopt-report-phase=par pi.c fx.c -o par_pi_c
echo ...
echo "icc -O2 -qopenmp pi_par.c fx.c -o openmp_pi_c"
icc -O2 -qopenmp pi_par.c fx.c -o openmp_pi_c

echo ...
echo ...
echo ...
echo "Running Od_pi_c"
./Od_pi_c
echo ...
echo "Running O2_pi_c"
./O2_pi_c
echo ...
echo "Running ipo_pi_c"
./ipo_pi_c
echo ...
echo "Running ipo_xHost_pi_c"
./ipo_xHost_pi_c
echo ...
echo "Running puse_pi_c"
./puse_pi_c
echo ...
echo "Running par_pi_c"
./par_pi_c
echo ...
echo "Running par_ipo_pi_c"
./openmp_pi_c
echo ...
echo "Cleaning executables"
rm *.dpi *.lock *.dyn *.optrpt *_c
echo ...
