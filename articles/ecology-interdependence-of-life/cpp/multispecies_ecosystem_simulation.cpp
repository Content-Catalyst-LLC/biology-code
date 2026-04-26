/*
 * Multi-species ecosystem simulation in C++.
 *
 * This compact example simulates producers, herbivores, carnivores,
 * disturbance events, and a biomass or detrital pool.
 */

#include <algorithm>
#include <iostream>
#include <random>

int main() {
    const int time_steps = 150;

    double producers = 100.0;
    double herbivores = 30.0;
    double carnivores = 8.0;
    double biomass_pool = 60.0;

    std::mt19937 rng(42);
    std::uniform_real_distribution<double> uniform(0.0, 1.0);

    for (int t = 1; t <= time_steps; ++t) {
        if (uniform(rng) < 0.04) {
            producers *= 0.75;
            herbivores *= 0.75;
            biomass_pool *= 0.75;
        }

        double delta_producers =
            0.10 * producers * (1.0 - producers / 250.0) -
            0.0035 * producers * herbivores;

        double delta_herbivores =
            0.15 * 0.0035 * producers * herbivores -
            0.04 * herbivores -
            0.0020 * herbivores * carnivores;

        double delta_carnivores =
            0.10 * 0.0020 * herbivores * carnivores -
            0.03 * carnivores;

        double delta_biomass_pool =
            0.18 * producers -
            0.07 * herbivores -
            0.05 * carnivores -
            0.05 * biomass_pool +
            0.02 * (herbivores + carnivores);

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
