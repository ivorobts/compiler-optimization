echo "Cleaning executables"
rm *.dpi *.lock *.dyn *.optrpt *_pi
echo ...
# Quick Lab
echo "Compiling and running all Quick Lab exercises"
echo ...
echo "icc -O0 pi.c fx.c -o Od_pi"
icc -O0 pi.c fx.c -o Od_pi
echo ...
echo "icc -O2 pi.c fx.c -o O2_pi"
icc -O2 pi.c fx.c -o O2_pi
echo ...
echo "icc -O2 -ipo -qopt-report=3 -qopt-report-phase=ipo -qopt-report-file=./ipo-report_c.txt pi.c fx.c -o ipo_pi"
icc -O2 -ipo -qopt-report=3 -qopt-report-phase=ipo -qopt-report-file=./ipo-report_c.txt pi.c fx.c -o ipo_pi
echo ...
echo "icc -O2 -ipo -xHost -qopt-report=5 pi.c fx.c -o ipo_xHost_pi"
icc -O2 -ipo -xHost -qopt-report=5 pi.c fx.c -o ipo_xHost_pi
echo ...
echo "icc -prof-gen pi.c fx.c -o pgen_pi"
icc -prof-gen pi.c fx.c -o pgen_pi
echo ...
echo "Running pgen_pi"
./pgen_pi
echo ...
echo "icc -O2 -prof-use -ipo pi.c fx.c -o puse_pi"
icc -O2 -prof-use -ipo pi.c fx.c -o puse_pi
echo ...
echo "icc -O2 -parallel -qopt-report:3 -qopt-report-phase=par pi.c fx.c -o par_pi"
icc -O2 -parallel -qopt-report:3 -qopt-report-phase=par pi.c fx.c -o par_pi
echo ...
echo "icc -O2 -ipo -parallel -qopt-report:3 -qopt-report-phase=par pi.c fx.c -o ipo_par_pi"
icc -O2 -ipo -parallel -qopt-report:3 -qopt-report-phase=par pi.c fx.c -o ipo_par_pi
echo ...
echo "icc -O2 -qopenmp pi_par.c fx.c -o openmp_pi"
icc -O2 -qopenmp pi_par.c fx.c -o openmp_pi

echo ...
echo ...
echo ...
echo "Running Od_pi"
./Od_pi
echo ...
echo "Running O2_pi"
./O2_pi
echo ...
echo "Running ipo_pi"
./ipo_pi
echo ...
echo "Running ipo_xHost_pi"
./ipo_xHost_pi
echo ...
echo "Running puse_pi"
./puse_pi
echo ...
echo "Running par_pi"
./par_pi
echo ...
echo "Running ipo_par_pi"
./ipo_par_pi
echo ...
echo "Running openmp_pi"
./openmp_pi
echo ...
echo "Cleaning executables"
rm *.dpi *.lock *.dyn *.optrpt *_pi
echo ...
