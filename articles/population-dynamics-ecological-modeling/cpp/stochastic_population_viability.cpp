/*
 * Stochastic population viability simulation in C++.
 *
 * This compact example simulates logistic growth with harvest, environmental
 * variability, and catastrophe risk.
 */

#include <algorithm>
#include <iostream>
#include <random>
#include <vector>

int main() {
    const int years = 50;
    const int n_sims = 1000;

    const double initial_population = 80.0;
    const double growth_rate_mean = 0.18;
    const double growth_rate_sd = 0.08;
    const double carrying_capacity_mean = 500.0;
    const double carrying_capacity_sd = 40.0;
    const double harvest = 5.0;
    const double catastrophe_probability = 0.05;
    const double catastrophe_multiplier = 0.60;
    const double quasi_extinction_threshold = 20.0;

    std::mt19937 rng(123);
    std::normal_distribution<double> growth_dist(growth_rate_mean, growth_rate_sd);
    std::normal_distribution<double> capacity_dist(carrying_capacity_mean, carrying_capacity_sd);
    std::uniform_real_distribution<double> uniform(0.0, 1.0);

    int extinct_count = 0;
    int quasi_extinct_count = 0;
    double final_sum = 0.0;

    for (int sim = 0; sim < n_sims; ++sim) {
        double population_size = initial_population;
        double minimum_size = population_size;

        for (int year = 0; year < years; ++year) {
            double growth_rate_t = growth_dist(rng);
            double carrying_capacity_t = std::max(
                quasi_extinction_threshold,
                capacity_dist(rng)
            );

            population_size =
                population_size +
                growth_rate_t * population_size *
                (1.0 - population_size / carrying_capacity_t) -
                harvest;

            if (uniform(rng) < catastrophe_probability) {
                population_size *= catastrophe_multiplier;
            }

            population_size = std::max(0.0, population_size);
            minimum_size = std::min(minimum_size, population_size);

            if (population_size == 0.0) {
                break;
            }
        }

        if (population_size == 0.0) {
            extinct_count += 1;
        }

        if (minimum_size <= quasi_extinction_threshold) {
            quasi_extinct_count += 1;
        }

        final_sum += population_size;
    }

    std::cout << "extinction_risk=" << static_cast<double>(extinct_count) / n_sims << std::endl;
    std::cout << "quasi_extinction_risk=" << static_cast<double>(quasi_extinct_count) / n_sims << std::endl;
    std::cout << "mean_final_population=" << final_sum / n_sims << std::endl;

    return 0;
}
