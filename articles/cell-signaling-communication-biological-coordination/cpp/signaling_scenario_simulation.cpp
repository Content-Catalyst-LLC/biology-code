/*
 * Comparative signaling scenario simulation in C++.
 */

#include <iostream>
#include <string>
#include <vector>

struct SignalingScenario {
    std::string name;
    double receptor_detection;
    double transduction_integrity;
    double second_messenger_capacity;
    double feedback_control;
    double response_specificity;
    double context_integration;
    double noise_risk;
};

double signaling_score(const SignalingScenario& s) {
    return 0.16 * s.receptor_detection
        + 0.16 * s.transduction_integrity
        + 0.14 * s.second_messenger_capacity
        + 0.15 * s.feedback_control
        + 0.14 * s.response_specificity
        + 0.15 * s.context_integration
        + 0.10 * (1.0 - s.noise_risk);
}

int main() {
    std::vector<SignalingScenario> scenarios = {
        {"reference_cell_state", 0.84, 0.80, 0.78, 0.74, 0.76, 0.72, 0.20},
        {"feedback_deficient_state", 0.72, 0.68, 0.70, 0.32, 0.48, 0.52, 0.64},
        {"immune_activation_state", 0.88, 0.82, 0.86, 0.70, 0.80, 0.78, 0.28},
        {"microbial_quorum_state", 0.76, 0.70, 0.62, 0.58, 0.66, 0.74, 0.34},
        {"plant_stress_state", 0.80, 0.76, 0.68, 0.64, 0.72, 0.84, 0.30}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " signaling_condition_score=" << signaling_score(scenario)
            << std::endl;
    }

    return 0;
}
