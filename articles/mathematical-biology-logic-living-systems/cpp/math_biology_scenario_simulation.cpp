/*
 * Comparative mathematical-biology scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct LogisticScenario {
    std::string name;
    double initial_population;
    double growth_rate;
    double carrying_capacity;
};

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * std::exp(-r * t));
}

double michaelis_menten(double substrate, double vmax, double km) {
    return vmax * substrate / (km + substrate);
}

int main() {
    std::vector<LogisticScenario> scenarios = {
        {"baseline", 100.0, 0.30, 2000.0},
        {"resource_limited", 100.0, 0.18, 900.0},
        {"rapid_growth", 100.0, 0.45, 2600.0},
        {"low_capacity", 100.0, 0.30, 600.0}
    };

    for (const auto& scenario : scenarios) {
        double final_population = logistic_growth(
            40.0,
            scenario.initial_population,
            scenario.growth_rate,
            scenario.carrying_capacity
        );

        std::cout
            << "scenario=" << scenario.name
            << " final_population=" << final_population
            << " fraction_capacity=" << final_population / scenario.carrying_capacity
            << std::endl;
    }

    std::cout << "michaelis_menten_velocity=" << michaelis_menten(5.0, 10.0, 2.0) << std::endl;

    return 0;
}
