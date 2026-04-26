/*
 * Comparative genomics scenario simulation in C++.
 */

#include <iostream>
#include <string>
#include <vector>

struct GenomicScenario {
    std::string name;
    double assembly_quality;
    double annotation_depth;
    double variant_quality;
    double expression_signal;
    double population_representation;
    double provenance_quality;
    double bias_risk;
};

double genomic_score(const GenomicScenario& s) {
    return 0.16 * s.assembly_quality
        + 0.16 * s.annotation_depth
        + 0.16 * s.variant_quality
        + 0.14 * s.expression_signal
        + 0.14 * s.population_representation
        + 0.14 * s.provenance_quality
        + 0.10 * (1.0 - s.bias_risk);
}

int main() {
    std::vector<GenomicScenario> scenarios = {
        {"reference_genome_project", 0.84, 0.78, 0.72, 0.66, 0.62, 0.80, 0.22},
        {"conservation_panel", 0.68, 0.61, 0.76, 0.40, 0.82, 0.74, 0.30},
        {"metagenomic_survey", 0.55, 0.58, 0.42, 0.36, 0.70, 0.64, 0.41},
        {"clinical_variant_screen", 0.72, 0.83, 0.88, 0.50, 0.58, 0.79, 0.27}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " genomic_condition_score=" << genomic_score(scenario)
            << std::endl;
    }

    return 0;
}
