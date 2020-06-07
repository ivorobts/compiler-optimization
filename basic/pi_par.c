#include <stdio.h>
#include <time.h>
#include <omp.h>

#define N 1000000000

double f( double x );

main()
{
	double sum, pi, x, h;
	clock_t start, stop;
        double t1, t2;
	int i;

        h = (double)1.0/(double)N;
        sum = 0.0;

        t1 = omp_get_wtime();
//#pragma omp parallel for reduction(+:sum) private(x)
        for ( i=0; i<N ; i++ ){
          x = h*(i-0.5);
          sum = sum + f(x);
        }

        t2 = omp_get_wtime();

	// print value of pi to be sure multiplication is correct
        pi = h*sum;
        printf("    pi is approximately : %f \n", pi);
        printf("Elapsed time = %lf seconds\n",t2-t1);
}
