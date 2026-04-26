/*
 * Comparative molecular scenario simulation in C++.
 */

#include <iostream>
#include <string>
#include <vector>

struct MolecularScenario {
    std::string name;
    double replication_fidelity;
    double transcription_signal;
    double rna_stability;
    double translation_support;
    double repair_capacity;
    double regulatory_context;
    double damage_risk;
};

double molecular_score(const MolecularScenario& s) {
    return 0.16 * s.replication_fidelity
        + 0.16 * s.transcription_signal
        + 0.14 * s.rna_stability
        + 0.14 * s.translation_support
        + 0.16 * s.repair_capacity
        + 0.14 * s.regulatory_context
        + 0.10 * (1.0 - s.damage_risk);
}

int main() {
    std::vector<MolecularScenario> scenarios = {
        {"reference_cell_state", 0.86, 0.72, 0.70, 0.78, 0.82, 0.74, 0.18},
        {"stress_response_state", 0.70, 0.88, 0.46, 0.66, 0.64, 0.82, 0.38},
        {"damage_repair_deficient", 0.42, 0.58, 0.54, 0.61, 0.28, 0.50, 0.77},
        {"high_expression_program", 0.74, 0.92, 0.69, 0.84, 0.66, 0.79, 0.29}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " molecular_condition_score=" << molecular_score(scenario)
            << std::endl;
    }

    return 0;
}
