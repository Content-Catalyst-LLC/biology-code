/*
 * Comparative heredity scenario simulation in C++.
 */

#include <iostream>
#include <string>
#include <vector>

struct HeredityScenario {
    std::string name;
    double standing_variation;
    double inheritance_clarity;
    double recombination_information;
    double population_size;
    double genotype_quality;
    double environmental_context;
    double inbreeding_risk;
};

double heredity_score(const HeredityScenario& s) {
    return 0.18 * s.standing_variation
        + 0.14 * s.inheritance_clarity
        + 0.12 * s.recombination_information
        + 0.15 * s.population_size
        + 0.15 * s.genotype_quality
        + 0.14 * s.environmental_context
        + 0.12 * (1.0 - s.inbreeding_risk);
}

int main() {
    std::vector<HeredityScenario> scenarios = {
        {"reference_population", 0.76, 0.78, 0.64, 0.72, 0.81, 0.70, 0.18},
        {"bottlenecked_population", 0.32, 0.66, 0.40, 0.28, 0.70, 0.58, 0.72},
        {"crop_breeding_panel", 0.82, 0.74, 0.70, 0.68, 0.76, 0.62, 0.22},
        {"restoration_seed_source", 0.58, 0.60, 0.44, 0.52, 0.66, 0.80, 0.36}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " heredity_condition_score=" << heredity_score(scenario)
            << std::endl;
    }

    return 0;
}
