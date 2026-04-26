/*
 * Comparative mutation and novelty scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    double mutation_supply;
    double standing_variation;
    double recombination_potential;
    double regulatory_flexibility;
    double developmental_modularity;
    double ecological_opportunity;
    double constraint_risk;
};

double novelty_score(const Scenario& s) {
    return 0.15 * s.mutation_supply
        + 0.17 * s.standing_variation
        + 0.14 * s.recombination_potential
        + 0.15 * s.regulatory_flexibility
        + 0.15 * s.developmental_modularity
        + 0.14 * s.ecological_opportunity
        + 0.10 * (1.0 - s.constraint_risk);
}

int main() {
    std::vector<Scenario> scenarios = {
        {"reference_population", 0.58, 0.74, 0.66, 0.62, 0.61, 0.55, 0.22},
        {"bottlenecked_population", 0.31, 0.28, 0.32, 0.40, 0.45, 0.48, 0.68},
        {"microbial_stress_system", 0.88, 0.69, 0.54, 0.76, 0.52, 0.84, 0.30},
        {"crop_breeding_panel", 0.63, 0.81, 0.79, 0.58, 0.56, 0.61, 0.24}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " novelty_condition_score=" << novelty_score(scenario)
            << std::endl;
    }

    return 0;
}
