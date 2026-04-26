/*
 * Compact reproductive replacement and stage-transition kernel in C.
 *
 * Demonstrates:
 * N(t+1) = R0 * N(t)
 * and one simple stage-matrix update.
 */

#include <stdio.h>

double generational_replacement(double population, double r0) {
    return r0 * population;
}

int main(void) {
    double population = 100.0;
    double r0_growth = 1.2;
    double r0_decline = 0.8;

    double juvenile = 50.0;
    double subadult = 20.0;
    double adult = 15.0;

    double next_juvenile = 1.8 * adult;
    double next_subadult = 0.45 * juvenile;
    double next_adult = 0.70 * subadult + 0.82 * adult;

    printf("replacement_growth=%.3f\n", generational_replacement(population, r0_growth));
    printf("replacement_decline=%.3f\n", generational_replacement(population, r0_decline));
    printf("next_juvenile=%.3f\n", next_juvenile);
    printf("next_subadult=%.3f\n", next_subadult);
    printf("next_adult=%.3f\n", next_adult);

    return 0;
}
