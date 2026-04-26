/*
 * Compact survivorship and recovery kernel in C.
 */

#include <math.h>
#include <stdio.h>

double survivorship(double lambda, double t) {
    return exp(-lambda * t);
}

double recovery(double n0, double r, double k, double t) {
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t));
}

int main(void) {
    const double initial = 120.0;
    const double survivors = 30.0;

    const double s = survivors / initial;
    const double e = 1.0 - s;

    printf("survivorship=%.4f\n", s);
    printf("extinction=%.4f\n", e);
    printf("hazard_survivorship_t10=%.4f\n", survivorship(0.18, 10.0));
    printf("recovery_richness_t30=%.4f\n", recovery(5.0, 0.14, 60.0, 30.0));

    return 0;
}
