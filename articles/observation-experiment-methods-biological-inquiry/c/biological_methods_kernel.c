/*
 * Compact biological-methods numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>
#include <string.h>

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t));
}

int hamming_distance(const char *a, const char *b) {
    int n = (int)strlen(a);
    int distance = 0;

    if (n != (int)strlen(b)) {
        return -1;
    }

    for (int i = 0; i < n; i++) {
        if (a[i] != b[i]) distance++;
    }

    return distance;
}

int main(void) {
    double r = log(10.0) / 10.0;
    double sensitivity = 84.0 / (84.0 + 16.0);
    double specificity = 91.0 / (91.0 + 9.0);

    printf("growth_rate=%.6f\n", r);
    printf("doubling_time=%.6f\n", log(2.0) / r);
    printf("logistic_24=%.3f\n", logistic_growth(24.0, 1.0e5, 0.45, 2.0e6));
    printf("sensitivity=%.6f\n", sensitivity);
    printf("specificity=%.6f\n", specificity);
    printf("hamming_distance=%d\n", hamming_distance("ATGCTAGCTAAC", "ATGCTAGCTATC"));

    return 0;
}
