/*
 * Compact logistic growth and harvest kernel in C.
 *
 * N(t+1) = N(t) + rN(t)(1 - N(t)/K) - H
 */

#include <math.h>
#include <stdio.h>

double logistic_harvest_update(
    double population_size,
    double growth_rate,
    double carrying_capacity,
    double harvest
) {
    double growth = growth_rate * population_size *
        (1.0 - population_size / carrying_capacity);

    double next_population = population_size + growth - harvest;

    if (next_population < 0.0) {
        return 0.0;
    }

    return next_population;
}

int main(void) {
    double population_size = 80.0;
    double growth_rate = 0.18;
    double carrying_capacity = 500.0;
    double harvest = 5.0;

    for (int year = 0; year < 50; year++) {
        population_size = logistic_harvest_update(
            population_size,
            growth_rate,
            carrying_capacity,
            harvest
        );
    }

    printf("final_population_size=%.3f\n", population_size);

    return 0;
}
