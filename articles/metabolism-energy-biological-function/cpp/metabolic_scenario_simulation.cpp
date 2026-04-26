/*
 * Comparative metabolic scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct MetabolicScenario {
    std::string name;
    double substrate_availability;
    double energy_conversion;
    double redox_balance;
    double growth_capacity;
    double maintenance_resilience;
    double pathway_integration;
    double stress_penalty;
};

double metabolic_score(const MetabolicScenario& s) {
    return 0.16 * s.substrate_availability
        + 0.17 * s.energy_conversion
        + 0.15 * s.redox_balance
        + 0.14 * s.growth_capacity
        + 0.14 * s.maintenance_resilience
        + 0.14 * s.pathway_integration
        + 0.10 * (1.0 - s.stress_penalty);
}

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * std::exp(-r * t));
}

int main() {
    std::vector<MetabolicScenario> scenarios = {
        {"reference_cell_state", 0.84, 0.82, 0.78, 0.80, 0.74, 0.76, 0.18},
        {"nutrient_limited_state", 0.38, 0.70, 0.66, 0.42, 0.62, 0.58, 0.40},
        {"hypoxic_state", 0.72, 0.40, 0.36, 0.46, 0.58, 0.52, 0.62},
        {"microbial_soil_system", 0.78, 0.74, 0.70, 0.72, 0.80, 0.84, 0.26},
        {"plant_stress_state", 0.62, 0.68, 0.64, 0.58, 0.76, 0.72, 0.34}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " metabolic_condition_score=" << metabolic_score(scenario)
            << std::endl;
    }

    std::cout << "control_logistic_96h=" << logistic_growth(96.0, 1.0e5, 0.035, 1.0e6) << std::endl;
    std::cout << "stress_logistic_96h=" << logistic_growth(96.0, 1.0e5, 0.020, 1.0e6) << std::endl;

    return 0;
}
