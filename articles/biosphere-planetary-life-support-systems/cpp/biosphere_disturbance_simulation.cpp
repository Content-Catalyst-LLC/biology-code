/*
 * Biosphere disturbance simulation in C++.
 *
 * This compact example tracks functional biomass under productivity,
 * respiration, disturbance, land-use loss, and regrowth.
 */

#include <algorithm>
#include <iostream>
#include <random>
#include <vector>

int main() {
    const int years = 60;
    std::vector<double> biomass(years + 1, 0.0);
    biomass[0] = 100.0;

    const double npp_base = 8.0;
    const double respiration_rate = 0.035;
    const double disturbance_base = 1.2;
    const double land_use_loss = 0.8;
    const double regrowth_rate = 0.025;

    std::mt19937 rng(123);
    std::normal_distribution<double> climate_variability(0.0, 0.5);
    std::normal_distribution<double> disturbance_variability(0.0, 0.3);

    for (int year = 0; year < years; ++year) {
        double npp = std::max(0.0, npp_base + climate_variability(rng));
        double respiration = respiration_rate * biomass[year];
        double disturbance = std::max(0.0, disturbance_base + disturbance_variability(rng));
        double regrowth = regrowth_rate * std::max(0.0, 140.0 - biomass[year]);

        double delta = npp - respiration - disturbance - land_use_loss + regrowth;
        biomass[year + 1] = std::max(0.0, biomass[year] + delta);
    }

    std::cout << "final_functional_biomass=" << biomass.back() << std::endl;

    return 0;
}
