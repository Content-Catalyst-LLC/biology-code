/*
 * Compact epigenetics and gene-expression kernel in C.
 */

#include <math.h>
#include <stdio.h>

double transcript_decay(double m0, double k, double t) {
    return m0 * exp(-k * t);
}

double transcript_half_life(double k) {
    return log(2.0) / k;
}

double methylation_fraction(double methylated, double unmethylated) {
    double total = methylated + unmethylated;

    if (total <= 0.0) {
        return NAN;
    }

    return methylated / total;
}

double regulatory_steady_state(double kon, double koff) {
    return kon / (kon + koff);
}

int main(void) {
    double m0 = 120.0;
    double k = log(4.0) / 6.0;
    double log2fc = log((25.0 + 1e-6) / (12.0 + 1e-6)) / log(2.0);

    printf("expression_at_6h=%.6f\n", transcript_decay(m0, k, 6.0));
    printf("half_life_h=%.6f\n", transcript_half_life(k));
    printf("methylation_fraction=%.6f\n", methylation_fraction(85.0, 15.0));
    printf("p_on_steady_state=%.6f\n", regulatory_steady_state(0.28, 0.10));
    printf("log2FC_expr=%.6f\n", log2fc);

    return 0;
}
