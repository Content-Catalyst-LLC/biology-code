/*
 * Compact taxonomy numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>
#include <string.h>

double p_distance(const char *a, const char *b) {
    int n = (int)strlen(a);
    int differences = 0;

    if (n != (int)strlen(b)) {
        return NAN;
    }

    for (int i = 0; i < n; i++) {
        if (a[i] != b[i]) differences++;
    }

    return (double)differences / (double)n;
}

double jukes_cantor(double p) {
    if (p >= 0.75) return NAN;
    return -0.75 * log(1.0 - (4.0 / 3.0) * p);
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

double confidence_score(double s, double m, double g, double p, double u) {
    return 0.30*s + 0.20*m + 0.15*g + 0.25*p - 0.10*u;
}

int main(void) {
    double counts[4] = {25.0, 18.0, 11.0, 6.0};
    double p = p_distance("ATGCTAGCTAAC", "ATGCTAGCTATC");

    printf("p_distance=%.6f\n", p);
    printf("jukes_cantor=%.6f\n", jukes_cantor(p));
    printf("shannon=%.6f\n", shannon(counts, 4));
    printf("confidence=%.6f\n", confidence_score(0.98, 0.90, 0.88, 0.94, 0.05));

    return 0;
}
