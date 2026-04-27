/*
 * Compact statistics and measurement numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>

double mean(const double *values, int n) {
    double total = 0.0;
    for (int i = 0; i < n; i++) total += values[i];
    return total / n;
}

double sample_sd(const double *values, int n) {
    double m = mean(values, n);
    double sumsq = 0.0;
    for (int i = 0; i < n; i++) sumsq += pow(values[i] - m, 2.0);
    return sqrt(sumsq / (n - 1));
}

double combined_uncertainty(const double *components, int n) {
    double sumsq = 0.0;
    for (int i = 0; i < n; i++) sumsq += components[i] * components[i];
    return sqrt(sumsq);
}

int main(void) {
    double values[10] = {10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4, 11.3, 10.7};
    double components[5] = {0.12, 0.08, 0.15, 0.06, 0.05};

    double m = mean(values, 10);
    double sd = sample_sd(values, 10);
    double se = sd / sqrt(10.0);
    double uc = combined_uncertainty(components, 5);

    printf("mean=%.6f\n", m);
    printf("standard_deviation=%.6f\n", sd);
    printf("standard_error=%.6f\n", se);
    printf("ci_lower=%.6f\n", m - 1.96 * se);
    printf("ci_upper=%.6f\n", m + 1.96 * se);
    printf("combined_standard_uncertainty=%.6f\n", uc);
    printf("expanded_uncertainty=%.6f\n", 2.0 * uc);

    return 0;
}
