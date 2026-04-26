/*
 * Compact evolution kernel in C.
 */

#include <math.h>
#include <stdio.h>

double mean_fitness(double p, double w_AA, double w_Aa, double w_aa) {
    double q = 1.0 - p;
    return p * p * w_AA + 2.0 * p * q * w_Aa + q * q * w_aa;
}

double selection_update(double p, double w_AA, double w_Aa, double w_aa) {
    double q = 1.0 - p;
    double wbar = mean_fitness(p, w_AA, w_Aa, w_aa);
    return (p * p * w_AA + p * q * w_Aa) / wbar;
}

double jukes_cantor(double d) {
    if (d >= 0.75) {
        return NAN;
    }

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * d);
}

int main(void) {
    double p = 0.2;
    double p_next = selection_update(p, 1.12, 1.05, 1.0);
    double lambda = 0.10;
    double mu = 0.03;
    double r = lambda - mu;

    printf("mean_fitness=%.6f\n", mean_fitness(p, 1.12, 1.05, 1.0));
    printf("p_next=%.6f\n", p_next);
    printf("delta_p=%.6f\n", p_next - p);
    printf("jukes_cantor=%.6f\n", jukes_cantor(0.15));
    printf("net_diversification=%.6f\n", r);
    printf("expected_richness=%.6f\n", 8.0 * exp(r * 50.0));

    return 0;
}
