/*
 * Comparative enzyme and biochemical pathway scenario simulation in C++.
 */

#include <iostream>
#include <string>
#include <vector>

struct EnzymeScenario {
    std::string name;
    double catalytic_capacity;
    double substrate_access;
    double regulatory_control;
    double cofactor_availability;
    double pathway_integration;
    double environmental_stability;
    double inhibition_risk;
};

double enzyme_pathway_score(const EnzymeScenario& s) {
    return 0.17 * s.catalytic_capacity
        + 0.14 * s.substrate_access
        + 0.15 * s.regulatory_control
        + 0.14 * s.cofactor_availability
        + 0.16 * s.pathway_integration
        + 0.14 * s.environmental_stability
        + 0.10 * (1.0 - s.inhibition_risk);
}

int main() {
    std::vector<EnzymeScenario> scenarios = {
        {"reference_pathway", 0.84, 0.78, 0.76, 0.80, 0.74, 0.72, 0.18},
        {"inhibited_pathway", 0.52, 0.70, 0.48, 0.68, 0.58, 0.62, 0.68},
        {"cofactor_limited_state", 0.62, 0.74, 0.66, 0.32, 0.54, 0.58, 0.42},
        {"microbial_soil_pathway", 0.78, 0.82, 0.70, 0.76, 0.84, 0.64, 0.26},
        {"thermal_stress_state", 0.50, 0.68, 0.58, 0.60, 0.52, 0.34, 0.46}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " enzyme_pathway_score=" << enzyme_pathway_score(scenario)
            << std::endl;
    }

    return 0;
}
