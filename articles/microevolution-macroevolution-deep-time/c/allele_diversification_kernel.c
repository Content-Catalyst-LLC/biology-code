/*
 * Compact allele-frequency and diversification kernel in C.
 */

#include <math.h>
#include <stdio.h>

double selection_update(double p, double w_AA, double w_Aa, double w_aa) {
    double q = 1.0 - p;
    double f_AA = p * p;
    double f_Aa = 2.0 * p * q;
    double f_aa = q * q;

    double wbar = f_AA * w_AA + f_Aa * w_Aa + f_aa * w_aa;
    return (f_AA * w_AA + 0.5 * f_Aa * w_Aa) / wbar;
}

double jukes_cantor(double p_distance) {
    if (p_distance >= 0.75) {
        return NAN;
    }

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * p_distance);
}

int main(void) {
    double p = 0.8;
    double q = 1.0 - p;

    printf("AA=%.4f\n", p * p);
    printf("Aa=%.4f\n", 2.0 * p * q);
    printf("aa=%.4f\n", q * q);

    printf("selection_p_next=%.6f\n", selection_update(0.2, 1.15, 1.08, 1.0));
    printf("jukes_cantor=%.6f\n", jukes_cantor(0.15));

    double lambda = 0.12;
    double mu = 0.08;
    double r = lambda - mu;
    double n0 = 20.0;
    double t = 50.0;

    printf("net_diversification=%.4f\n", r);
    printf("expected_lineages=%.4f\n", n0 * exp(r * t));

    return 0;
}
