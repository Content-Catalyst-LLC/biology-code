#include <cmath>
#include <iostream>
#include <string>
#include <vector>

// Evolutionary mismatch scenario ranking example.

struct MismatchScenario {
    std::string trait_system;
    double current_exposure;
    double adapted_reference;
    double evidence_confidence;
};

double weighted_mismatch_score(const MismatchScenario& item) {
    return std::abs(item.current_exposure - item.adapted_reference) * item.evidence_confidence;
}

int main() {
    std::vector<MismatchScenario> scenarios = {
        {"energy_storage", 0.90, 0.45, 0.70},
        {"circadian_regulation", 0.82, 0.35, 0.65},
        {"immune_calibration", 0.25, 0.70, 0.55}
    };

    for (const auto& item : scenarios) {
        std::cout << item.trait_system
                  << " weighted_mismatch_score="
                  << weighted_mismatch_score(item)
                  << std::endl;
    }

    return 0;
}
