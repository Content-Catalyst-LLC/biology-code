/*
 * Compact biodiversity metric kernel in C.
 *
 * Calculates richness, Shannon diversity, Simpson diversity, and Hill q=1.
 */

#include <math.h>
#include <stdio.h>

int richness(double counts[], int n) {
    int observed = 0;

    for (int i = 0; i < n; i++) {
        if (counts[i] > 0.0) {
            observed++;
        }
    }

    return observed;
}

double shannon_diversity(double counts[], int n) {
    double total = 0.0;
    double shannon = 0.0;

    for (int i = 0; i < n; i++) {
        total += counts[i];
    }

    if (total <= 0.0) {
        return 0.0;
    }

    for (int i = 0; i < n; i++) {
        if (counts[i] > 0.0) {
            double p = counts[i] / total;
            shannon -= p * log(p);
        }
    }

    return shannon;
}

double simpson_diversity(double counts[], int n) {
    double total = 0.0;
    double concentration = 0.0;

    for (int i = 0; i < n; i++) {
        total += counts[i];
    }

    if (total <= 0.0) {
        return 0.0;
    }

    for (int i = 0; i < n; i++) {
        double p = counts[i] / total;
        concentration += p * p;
    }

    return 1.0 - concentration;
}

int main(void) {
    double counts[] = {12.0, 8.0, 0.0, 5.0, 3.0};
    int n = sizeof(counts) / sizeof(counts[0]);

    double shannon = shannon_diversity(counts, n);

    printf("richness=%d\n", richness(counts, n));
    printf("shannon=%.3f\n", shannon);
    printf("hill_q1=%.3f\n", exp(shannon));
    printf("simpson=%.3f\n", simpson_diversity(counts, n));

    return 0;
}
