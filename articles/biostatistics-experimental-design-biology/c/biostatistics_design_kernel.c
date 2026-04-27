/*
 * Compact biostatistics and experimental-design numerical kernel in C.
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

int main(void) {
    double control[8] = {10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4};
    double treated[8] = {12.1, 11.7, 12.4, 11.9, 12.0, 12.6, 11.8, 12.3};

    double mean0 = mean(control, 8);
    double mean1 = mean(treated, 8);
    double sd0 = sample_sd(control, 8);
    double sd1 = sample_sd(treated, 8);

    double pooled_sd = sqrt(((8 - 1) * sd0 * sd0 + (8 - 1) * sd1 * sd1) / (8 + 8 - 2));
    double difference = mean1 - mean0;
    double effect_size_d = difference / pooled_sd;
    double se_difference = sqrt(sd0 * sd0 / 8.0 + sd1 * sd1 / 8.0);
    double approx_n = 2.0 * pow(1.96 + 0.84, 2.0) / pow(0.8, 2.0);

    printf("control_mean=%.6f\n", mean0);
    printf("treated_mean=%.6f\n", mean1);
    printf("mean_difference=%.6f\n", difference);
    printf("pooled_sd=%.6f\n", pooled_sd);
    printf("effect_size_d=%.6f\n", effect_size_d);
    printf("se_difference=%.6f\n", se_difference);
    printf("approx_n_per_group_for_d_0_8=%.3f\n", approx_n);

    return 0;
}
