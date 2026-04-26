/*
 * Compact mutation and variation kernel in C.
 */

#include <math.h>
#include <stdio.h>

double expected_mutations(double n_genomes, double target_length, double mu) {
    return n_genomes * target_length * mu;
}

double jukes_cantor(double d) {
    if (d >= 0.75) {
        return NAN;
    }

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * d);
}

double mutation_selection_balance(double mu, double s) {
    return sqrt(mu / s);
}

int main(void) {
    double p = 0.6;
    double q = 1.0 - p;

    printf("expected_mutations=%.6f\n", expected_mutations(500.0, 1.2e8, 1e-8));
    printf("AA=%.6f\n", p * p);
    printf("Aa=%.6f\n", 2.0 * p * q);
    printf("aa=%.6f\n", q * q);
    printf("jukes_cantor=%.6f\n", jukes_cantor(0.15));
    printf("mutation_selection_balance_q=%.6f\n", mutation_selection_balance(1e-5, 0.01));
    printf("pi_site=%.6f\n", 2.0 * p * (1.0 - p));

    return 0;
}
