/*
 * Comparative taxonomic assignment simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Assignment {
    std::string record_id;
    std::string candidate_taxon;
    double sequence_similarity;
    double morphological_support;
    double geographic_plausibility;
    double phylogenetic_support;
    double uncertainty_penalty;
};

double confidence_score(const Assignment& a) {
    return 0.30 * a.sequence_similarity
        + 0.20 * a.morphological_support
        + 0.15 * a.geographic_plausibility
        + 0.25 * a.phylogenetic_support
        - 0.10 * a.uncertainty_penalty;
}

std::string confidence_class(double score) {
    if (score >= 0.75) return "high_confidence";
    if (score >= 0.55) return "moderate_confidence";
    return "low_confidence";
}

int main() {
    std::vector<Assignment> assignments = {
        {"obs_001", "Species_A", 0.98, 0.90, 0.88, 0.94, 0.05},
        {"obs_002", "Species_B", 0.91, 0.65, 0.82, 0.70, 0.20},
        {"obs_003", "Species_C", 0.84, 0.78, 0.55, 0.62, 0.32},
        {"obs_004", "Species_D", 0.73, 0.40, 0.30, 0.45, 0.55}
    };

    for (const auto& a : assignments) {
        double score = confidence_score(a);
        std::cout
            << "record_id=" << a.record_id
            << " candidate_taxon=" << a.candidate_taxon
            << " score=" << score
            << " class=" << confidence_class(score)
            << std::endl;
    }

    return 0;
}
