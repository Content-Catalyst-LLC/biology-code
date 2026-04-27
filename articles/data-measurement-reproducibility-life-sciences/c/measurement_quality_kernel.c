/*
 * Compact measurement quality and uncertainty kernel in C.
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

    for (int i = 0; i < n; i++) {
        sumsq += pow(values[i] - m, 2.0);
    }

    return sqrt(sumsq / (n - 1));
}

double combined_uncertainty(const double *components, int n) {
    double sumsq = 0.0;

    for (int i = 0; i < n; i++) {
        sumsq += components[i] * components[i];
    }

    return sqrt(sumsq);
}

int main(void) {
    double values[10] = {10.2, 10.5, 10.1, 10.4, 10.8, 10.7, 10.6, 10.3, 10.9, 10.4};
    double components[4] = {0.08, 0.05, 0.11, 0.06};

    double mean_value = mean(values, 10);
    double sd_value = sample_sd(values, 10);
    double cv = sd_value / mean_value;
    double uc = combined_uncertainty(components, 4);

    printf("mean_value=%.6f\n", mean_value);
    printf("sample_sd=%.6f\n", sd_value);
    printf("coefficient_of_variation=%.6f\n", cv);
    printf("combined_standard_uncertainty=%.6f\n", uc);
    printf("expanded_uncertainty=%.6f\n", 2.0 * uc);

    return 0;
}
