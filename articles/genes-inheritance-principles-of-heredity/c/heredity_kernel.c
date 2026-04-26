/*
 * Compact heredity kernel in C.
 */

#include <math.h>
#include <stdio.h>

double expected_heterozygosity(double p) {
    return 2.0 * p * (1.0 - p);
}

double chi_square_2(double obs1, double exp1, double obs2, double exp2) {
    return pow(obs1 - exp1, 2.0) / exp1 + pow(obs2 - exp2, 2.0) / exp2;
}

double recombination_fraction(double recombinants, double total) {
    return recombinants / total;
}

double narrow_sense_heritability(double VA, double VP) {
    return VA / VP;
}

int main(void) {
    double p = 0.7;
    double q = 1.0 - p;
    double h2 = narrow_sense_heritability(4.0, 13.0);
    double S = 5.0;

    printf("AA=%.6f\n", p * p);
    printf("Aa=%.6f\n", 2.0 * p * q);
    printf("aa=%.6f\n", q * q);
    printf("expected_heterozygosity=%.6f\n", expected_heterozygosity(p));
    printf("chi_square=%.6f\n", chi_square_2(315.0, 315.0, 105.0, 105.0));
    printf("recombination_fraction=%.6f\n", recombination_fraction(185.0, 1000.0));
    printf("h2=%.6f\n", h2);
    printf("predicted_response=%.6f\n", h2 * S);

    return 0;
}
