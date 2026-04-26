/*
 * Compact logistic growth and biomass balance kernel in C.
 *
 * This example updates producer population size and an ecosystem biomass pool.
 */

#include <stdio.h>

double logistic_delta(double population, double growth_rate, double carrying_capacity) {
    return growth_rate * population * (1.0 - population / carrying_capacity);
}

double biomass_delta(
    double producers,
    double herbivores,
    double carnivores,
    double biomass_pool,
    double biomass_loss_rate
) {
    return 0.20 * producers
         - 0.08 * herbivores
         - 0.05 * carnivores
         - biomass_loss_rate * biomass_pool
         + 0.03 * (herbivores + carnivores);
}

int main(void) {
    double producers = 80.0;
    double herbivores = 20.0;
    double carnivores = 5.0;
    double biomass_pool = 50.0;

    double d_producers = logistic_delta(producers, 0.08, 200.0);
    double d_biomass = biomass_delta(producers, herbivores, carnivores, biomass_pool, 0.04);

    printf("producer_delta=%.3f\n", d_producers);
    printf("biomass_pool_delta=%.3f\n", d_biomass);

    return 0;
}
