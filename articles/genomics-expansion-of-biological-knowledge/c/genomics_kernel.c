/*
 * Compact genomics kernel in C.
 */

#include <math.h>
#include <stdio.h>

double expected_heterozygosity(double p) {
    return 2.0 * p * (1.0 - p);
}

double fst_style(double p1, double p2) {
    double pbar = (p1 + p2) / 2.0;
    double ht = 2.0 * pbar * (1.0 - pbar);
    double hs = (2.0 * p1 * (1.0 - p1) + 2.0 * p2 * (1.0 - p2)) / 2.0;

    if (ht <= 0.0) {
        return 0.0;
    }

    return (ht - hs) / ht;
}

double jukes_cantor(double d) {
    if (d >= 0.75) {
        return NAN;
    }

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * d);
}

int main(void) {
    double p = 0.8;
    double q = 1.0 - p;
    double log2fc = log((160.0 + 1.0) / (100.0 + 1.0)) / log(2.0);

    printf("AA=%.6f\n", p * p);
    printf("Aa=%.6f\n", 2.0 * p * q);
    printf("aa=%.6f\n", q * q);
    printf("expected_heterozygosity=%.6f\n", expected_heterozygosity(p));
    printf("fst_style=%.6f\n", fst_style(0.40, 0.75));
    printf("jukes_cantor=%.6f\n", jukes_cantor(0.15));
    printf("log2fc=%.6f\n", log2fc);

    return 0;
}
