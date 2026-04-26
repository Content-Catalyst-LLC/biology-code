/*
 * Compact genotype fitness and allele-frequency kernel in C.
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

int main(void) {
    double p = 0.2;
    double w_AA = 1.15;
    double w_Aa = 1.08;
    double w_aa = 1.0;

    double wbar = mean_fitness(p, w_AA, w_Aa, w_aa);
    double p_next = selection_update(p, w_AA, w_Aa, w_aa);

    printf("mean_fitness=%.6f\n", wbar);
    printf("p_next=%.6f\n", p_next);
    printf("delta_p=%.6f\n", p_next - p);

    printf("relative_fitness_AA=%.4f\n", 8.0 / 10.0);
    printf("relative_fitness_Aa=%.4f\n", 10.0 / 10.0);
    printf("relative_fitness_aa=%.4f\n", 5.0 / 10.0);

    return 0;
}
