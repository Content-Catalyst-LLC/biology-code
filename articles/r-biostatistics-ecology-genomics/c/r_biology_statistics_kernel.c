/*
 * R biology statistics kernel in C.
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

double log2_fold_change(const double *control, int n_control, const double *treated, int n_treated, double pseudocount) {
    return log2((mean(treated, n_treated) + pseudocount) / (mean(control, n_control) + pseudocount));
}

int main(void) {
    double control[6] = {10.2, 10.5, 10.1, 10.4, 10.3, 10.6};
    double treated[5] = {12.1, 12.4, 11.9, 12.0, 12.5};
    double counts[4] = {18.0, 7.0, 3.0, 0.0};
    double gene_control[3] = {120.0, 130.0, 125.0};
    double gene_treated[3] = {300.0, 310.0, 290.0};

    printf("control_mean=%.6f\n", mean(control, 6));
    printf("treated_mean=%.6f\n", mean(treated, 5));
    printf("control_sd=%.6f\n", sample_sd(control, 6));
    printf("shannon_diversity=%.6f\n", shannon_diversity(counts, 4));
    printf("gene_log2_fold_change=%.6f\n", log2_fold_change(gene_control, 3, gene_treated, 3, 1.0));

    return 0;
}
