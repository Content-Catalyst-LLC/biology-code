/*
 * Compact plant productivity and light-response kernel in C.
 */

#include <math.h>
#include <stdio.h>

double light_response(double irradiance, double alpha, double amax, double rd) {
    return (alpha * irradiance * amax) / (alpha * irradiance + amax) - rd;
}

int main(void) {
    const double gpp = 1800.0;
    const double ra = 700.0;
    const double rh = 680.0;

    const double npp = gpp - ra;
    const double nep = gpp - (ra + rh);

    const double assimilation = light_response(1000.0, 0.05, 18.0, 1.5);

    printf("NPP=%.3f\n", npp);
    printf("NEP=%.3f\n", nep);
    printf("assimilation_at_1000=%.3f\n", assimilation);

    return 0;
}
