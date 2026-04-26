/*
 * Compact genotype-frequency and selection kernel in C.
 */

#include <math.h>
#include <stdio.h>

double expected_heterozygosity(double p) {
    return 2.0 * p * (1.0 - p);
}

double selection_update(double p, double W_AA, double W_Aa, double W_aa) {
    double q = 1.0 - p;
    double f_AA = p * p;
    double f_Aa = 2.0 * p * q;
    double f_aa = q * q;
    double Wbar = f_AA * W_AA + f_Aa * W_Aa + f_aa * W_aa;

    return (f_AA * W_AA + 0.5 * f_Aa * W_Aa) / Wbar;
}

int main(void) {
    double p = 0.7;
    double q = 1.0 - p;

    printf("expected_AA=%.4f\n", p * p);
    printf("expected_Aa=%.4f\n", 2.0 * p * q);
    printf("expected_aa=%.4f\n", q * q);
    printf("expected_heterozygosity=%.4f\n", expected_heterozygosity(p));

    printf("selection_p_next=%.6f\n", selection_update(0.2, 1.15, 1.08, 1.0));

    return 0;
}
