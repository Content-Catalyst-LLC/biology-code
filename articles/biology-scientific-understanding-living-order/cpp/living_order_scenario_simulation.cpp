/*
 * Comparative living-order scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct LivingOrderScenario {
    std::string name;
    double homeostatic_regulation;
    double metabolic_throughput;
    double structural_integration;
    double developmental_coordination;
    double information_continuity;
    double ecological_relation;
    double stress_penalty;
};

double living_order_score(const LivingOrderScenario& s) {
    return 0.17 * s.homeostatic_regulation
        + 0.16 * s.metabolic_throughput
        + 0.15 * s.structural_integration
        + 0.13 * s.developmental_coordination
        + 0.15 * s.information_continuity
        + 0.14 * s.ecological_relation
        + 0.10 * (1.0 - s.stress_penalty);
}

double homeostatic_state(double time, double initial_value, double setpoint, double correction_rate) {
    return setpoint + (initial_value - setpoint) * std::exp(-correction_rate * time);
}

double logistic_growth(double time, double n0, double growth_rate, double carrying_capacity) {
    return carrying_capacity / (1.0 + ((carrying_capacity - n0) / n0) * std::exp(-growth_rate * time));
}

int main() {
    std::vector<LivingOrderScenario> scenarios = {
        {"reference_living_system", 0.86, 0.84, 0.82, 0.78, 0.88, 0.80, 0.18},
        {"metabolic_stress_state", 0.68, 0.38, 0.70, 0.66, 0.80, 0.72, 0.58},
        {"regulatory_failure_state", 0.34, 0.66, 0.70, 0.62, 0.78, 0.68, 0.64},
        {"developmental_disruption_state", 0.72, 0.70, 0.66, 0.36, 0.76, 0.68, 0.60},
        {"ecosystem_fragmentation_state", 0.70, 0.72, 0.64, 0.66, 0.74, 0.34, 0.70},
        {"recovery_state", 0.78, 0.76, 0.74, 0.72, 0.80, 0.76, 0.32}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " living_order_score=" << living_order_score(scenario)
            << std::endl;
    }

    std::cout << "homeostatic_state_t5=" << homeostatic_state(5.0, 10.0, 2.0, 0.4) << std::endl;
    std::cout << "logistic_growth_t40=" << logistic_growth(40.0, 100.0, 0.35, 1200.0) << std::endl;

    return 0;
}
