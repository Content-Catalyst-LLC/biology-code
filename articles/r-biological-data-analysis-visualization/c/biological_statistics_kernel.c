/*
 * Biological statistics kernel in C.
 */

#include <math.h>
#include <stdio.h>

double mean(const double *values, int n) {
    double total = 0.0;
    for (int i = 0; i < n; i++) {
        total += values[i];
    }
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

double shannon_diversity(const double *counts, int n) {
    double total = 0.0;
    double h = 0.0;

    for (int i = 0; i < n; i++) {
        if (counts[i] > 0.0) {
            total += counts[i];
        }
    }

    for (int i = 0; i < n; i++) {
        if (counts[i] > 0.0) {
            double p = counts[i] / total;
            h += -p * log(p);
        }
    }

    return h;
}

int main(void) {
    double values[6] = {10.2, 10.5, 10.1, 10.4, 10.3, 10.6};
    double counts[4] = {18.0, 7.0, 3.0, 0.0};

    double m = mean(values, 6);
    double sd = sample_sd(values, 6);

    printf("mean=%.6f\n", m);
    printf("sd=%.6f\n", sd);
    printf("cv=%.6f\n", sd / m);
    printf("shannon=%.6f\n", shannon_diversity(counts, 4));

    return 0;
}
