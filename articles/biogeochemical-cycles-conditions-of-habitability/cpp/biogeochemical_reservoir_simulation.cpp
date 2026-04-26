/*
 * Multi-reservoir biogeochemical simulation in C++.
 *
 * This compact example tracks cumulative atmospheric carbon burden and
 * cumulative coastal nitrogen surplus over time.
 */

#include <algorithm>
#include <iostream>
#include <random>

int main() {
    const int years = 60;

    double carbon_burden = 0.0;
    double nitrogen_surplus = 0.0;

    std::mt19937 rng(42);
    std::normal_distribution<double> land_uptake_noise(0.0, 0.4);
    std::normal_distribution<double> ocean_uptake_noise(0.0, 0.3);
    std::normal_distribution<double> disturbance_noise(0.0, 0.2);
    std::normal_distribution<double> assimilation_noise(0.0, 0.08);

    for (int year = 1; year <= years; ++year) {
        double fossil_emissions = 10.0 * std::pow(1.008, year - 1);
        double land_uptake = std::max(0.0, 3.0 + land_uptake_noise(rng));
        double ocean_uptake = std::max(0.0, 2.6 + ocean_uptake_noise(rng));
        double disturbance_release = std::max(0.0, 0.5 + disturbance_noise(rng));

        double reactive_nitrogen = 1.0 * std::pow(1.015, year - 1);
        double coastal_assimilation = std::clamp(0.65 + assimilation_noise(rng), 0.0, 1.0);

        double carbon_increment =
            fossil_emissions + disturbance_release - land_uptake - ocean_uptake;

        double nitrogen_increment = reactive_nitrogen * (1.0 - coastal_assimilation);

        carbon_burden += carbon_increment;
        nitrogen_surplus += nitrogen_increment;
    }

    std::cout << "final_carbon_burden=" << carbon_burden << std::endl;
    std::cout << "final_nitrogen_surplus=" << nitrogen_surplus << std::endl;

    return 0;
}
