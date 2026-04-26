/*
 * Comparative molecular information-flow scenario simulation in C++.
 */

#include <iostream>
#include <string>
#include <vector>

struct MolecularFlowScenario {
    std::string name;
    double replication_fidelity;
    double transcription_signal;
    double rna_processing;
    double translation_support;
    double repair_capacity;
    double regulatory_context;
    double expression_noise_risk;
};

double molecular_flow_score(const MolecularFlowScenario& s) {
    return 0.16 * s.replication_fidelity
        + 0.15 * s.transcription_signal
        + 0.14 * s.rna_processing
        + 0.14 * s.translation_support
        + 0.16 * s.repair_capacity
        + 0.15 * s.regulatory_context
        + 0.10 * (1.0 - s.expression_noise_risk);
}

int main() {
    std::vector<MolecularFlowScenario> scenarios = {
        {"reference_cell_state", 0.86, 0.74, 0.78, 0.80, 0.82, 0.76, 0.18},
        {"stress_response_state", 0.70, 0.90, 0.66, 0.68, 0.64, 0.84, 0.36},
        {"repair_deficient_state", 0.42, 0.58, 0.54, 0.60, 0.28, 0.52, 0.72},
        {"high_expression_program", 0.74, 0.92, 0.72, 0.84, 0.66, 0.80, 0.28},
        {"microbial_adaptation_state", 0.68, 0.78, 0.62, 0.70, 0.58, 0.74, 0.40}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " molecular_flow_score=" << molecular_flow_score(scenario)
            << std::endl;
    }

    return 0;
}
