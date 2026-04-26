/*
 * Compact logistic and Monod kernel in C.
 *
 * This example simulates substrate-limited microbial growth.
 */

#include <stdio.h>

int main(void) {
    const double dt = 0.1;
    const int n_steps = 481;

    double abundance = 10000.0;
    double substrate = 100.0;

    const double mu_max = 0.8;
    const double ks = 20.0;
    const double yield_coeff = 1000000.0;

    for (int step = 1; step < n_steps; ++step) {
        double mu = mu_max * substrate / (ks + substrate);
        double d_abundance = mu * abundance * dt;
        double d_substrate = -(d_abundance / yield_coeff);

        abundance += d_abundance;
        substrate += d_substrate;

        if (abundance < 0.0) {
            abundance = 0.0;
        }

        if (substrate < 0.0) {
            substrate = 0.0;
        }
    }

    printf("final_abundance=%.3f\n", abundance);
    printf("remaining_substrate=%.3f\n", substrate);

    return 0;
}
