/*
 * Compact biology-foundations numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>
#include <string.h>

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t));
}

double shannon(const double *counts, int n) {
    double total = 0.0;
    double h = 0.0;

    for (int i = 0; i < n; i++) total += counts[i];

    for (int i = 0; i < n; i++) {
        if (counts[i] > 0.0) {
            double p = counts[i] / total;
            h -= p * log(p);
        }
    }

    return h;
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
    double r = log(735.0 / 100.0) / 10.0;
    double p = 0.7;
    double q = 1.0 - p;
    double counts[5] = {25.0, 18.0, 11.0, 6.0, 4.0};

    printf("growth_rate=%.6f\n", r);
    printf("doubling_time=%.6f\n", log(2.0) / r);
    printf("logistic_20=%.3f\n", logistic_growth(20.0, 100.0, 0.35, 2000.0));
    printf("HW_AA=%.6f\n", p * p);
    printf("HW_Aa=%.6f\n", 2.0 * p * q);
    printf("HW_aa=%.6f\n", q * q);
    printf("shannon=%.6f\n", shannon(counts, 5));
    printf("sequence_similarity=%.6f\n", sequence_similarity("ATGCTAGCTAAC", "ATGCTAGCTATC"));

    return 0;
}
