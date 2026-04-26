/*
 * Compact modern-biology numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>
#include <string.h>

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t));
}

double selection_update(double p, double w_AA, double w_Aa, double w_aa) {
    double q = 1.0 - p;
    double wbar = p*p*w_AA + 2.0*p*q*w_Aa + q*q*w_aa;
    return (p*p*w_AA + p*q*w_Aa) / wbar;
}

double sequence_similarity(const char *a, const char *b) {
    int n = (int)strlen(a);
    int differences = 0;

    if (n != (int)strlen(b)) {
        return NAN;
    }

    for (int i = 0; i < n; i++) {
        if (a[i] != b[i]) differences++;
    }

    return 1.0 - ((double)differences / (double)n);
}

int main(void) {
    double r = log(708.0 / 100.0) / 10.0;
    double p = 0.7;
    double q = 1.0 - p;

    printf("growth_rate=%.6f\n", r);
    printf("doubling_time=%.6f\n", log(2.0) / r);
    printf("logistic_20=%.3f\n", logistic_growth(20.0, 100.0, 0.35, 2000.0));
    printf("HW_AA=%.6f\n", p * p);
    printf("HW_Aa=%.6f\n", 2.0 * p * q);
    printf("HW_aa=%.6f\n", q * q);
    printf("selection_update=%.6f\n", selection_update(0.5, 1.1, 1.05, 1.0));
    printf("sequence_similarity=%.6f\n", sequence_similarity("ATGCTAGCTAAC", "ATGCTAGCTATC"));

    return 0;
}
