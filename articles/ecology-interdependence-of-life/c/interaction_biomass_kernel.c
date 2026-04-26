/*
 * Compact ecological interaction and biomass balance kernel in C.
 *
 * This example calculates one update for producers, herbivores, carnivores,
 * and a biomass or detrital pool.
 */

#include <stdio.h>

double producer_delta(double producers, double herbivores) {
    return 0.10 * producers * (1.0 - producers / 250.0) -
        0.0035 * producers * herbivores;
}

double herbivore_delta(double producers, double herbivores, double carnivores) {
    return 0.15 * 0.0035 * producers * herbivores -
        0.04 * herbivores -
        0.0020 * herbivores * carnivores;
}

double carnivore_delta(double herbivores, double carnivores) {
    return 0.10 * 0.0020 * herbivores * carnivores -
        0.03 * carnivores;
}

double biomass_delta(double producers, double herbivores, double carnivores, double biomass_pool) {
    return 0.18 * producers -
        0.07 * herbivores -
        0.05 * carnivores -
        0.05 * biomass_pool +
        0.02 * (herbivores + carnivores);
}

int main(void) {
    double producers = 100.0;
    double herbivores = 30.0;
    double carnivores = 8.0;
    double biomass_pool = 60.0;

    printf("producer_delta=%.3f\n", producer_delta(producers, herbivores));
    printf("herbivore_delta=%.3f\n", herbivore_delta(producers, herbivores, carnivores));
    printf("carnivore_delta=%.3f\n", carnivore_delta(herbivores, carnivores));
    printf("biomass_delta=%.3f\n", biomass_delta(producers, herbivores, carnivores, biomass_pool));

    return 0;
}
