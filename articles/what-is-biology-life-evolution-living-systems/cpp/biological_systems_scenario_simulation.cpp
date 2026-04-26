/*
 * Comparative biological systems scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct GrowthScenario {
    std::string name;
    double initial_population;
    double growth_rate;
    double carrying_capacity;
};

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * std::exp(-r * t));
}

double shannon(const std::vector<double>& counts) {
    double total = 0.0;
    double h = 0.0;

    for (double count : counts) {
        total += count;
    }

    for (double count : counts) {
        if (count > 0.0) {
            double p = count / total;
            h -= p * std::log(p);
        }
    }

    return h;
}

int main() {
    std::vector<GrowthScenario> scenarios = {
        {"baseline", 100.0, 0.35, 2000.0},
        {"resource_limited", 100.0, 0.22, 900.0},
        {"rapid_growth", 100.0, 0.50, 2500.0},
        {"low_capacity", 100.0, 0.35, 600.0}
    };

    for (const auto& scenario : scenarios) {
        double final_population = logistic_growth(
            20.0,
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

    std::vector<double> counts = {25.0, 18.0, 11.0, 6.0, 4.0};
    std::cout << "shannon_diversity=" << shannon(counts) << std::endl;

    return 0;
}
