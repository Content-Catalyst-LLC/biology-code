/*
 * Coupled population-community-ecosystem simulation in C++.
 *
 * This compact example simulates producers, herbivores, carnivores,
 * disturbance events, and an ecosystem biomass pool.
 */

#include <algorithm>
#include <iostream>
#include <random>

int main() {
    const int time_steps = 200;

    double producers = 80.0;
    double herbivores = 20.0;
    double carnivores = 5.0;
    double biomass_pool = 50.0;

    std::mt19937 rng(42);
    std::uniform_real_distribution<double> uniform(0.0, 1.0);

    for (int t = 1; t <= time_steps; ++t) {
        if (uniform(rng) < 0.04) {
            producers *= 0.70;
            herbivores *= 0.70;
            biomass_pool *= 0.70;
        }

        double delta_producers =
            0.08 * producers * (1.0 - producers / 200.0) -
            0.003 * producers * herbivores;

        double delta_herbivores =
            0.12 * 0.003 * producers * herbivores -
            0.03 * herbivores -
            0.002 * herbivores * carnivores;

        double delta_carnivores =
            0.10 * 0.002 * herbivores * carnivores -
            0.02 * carnivores;

        double delta_biomass_pool =
            0.20 * producers -
            0.08 * herbivores -
            0.05 * carnivores -
            0.04 * biomass_pool +
            0.03 * (herbivores + carnivores);

        producers = std::max(0.0, producers + delta_producers);
        herbivores = std::max(0.0, herbivores + delta_herbivores);
        carnivores = std::max(0.0, carnivores + delta_carnivores);
        biomass_pool = std::max(0.0, biomass_pool + delta_biomass_pool);
    }

    std::cout << "final_producers=" << producers << std::endl;
    std::cout << "final_herbivores=" << herbivores << std::endl;
    std::cout << "final_carnivores=" << carnivores << std::endl;
    std::cout << "final_biomass_pool=" << biomass_pool << std::endl;

    return 0;
}
