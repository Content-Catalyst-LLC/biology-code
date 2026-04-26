/*
 * Comparative material-condition scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct MaterialConditionScenario {
    std::string name;
    double water_availability;
    double osmotic_stability;
    double energy_availability;
    double oxygen_support;
    double thermal_suitability;
    double ph_stability;
    double stress_penalty;
};

double material_condition_score(const MaterialConditionScenario& s) {
    return 0.17 * s.water_availability
        + 0.15 * s.osmotic_stability
        + 0.17 * s.energy_availability
        + 0.14 * s.oxygen_support
        + 0.13 * s.thermal_suitability
        + 0.14 * s.ph_stability
        + 0.10 * (1.0 - s.stress_penalty);
}

double osmotic_pressure(double i, double c, double r, double t) {
    return i * c * r * t;
}

double homeostatic_state(double time, double initial_value, double setpoint, double k) {
    return setpoint + (initial_value - setpoint) * std::exp(-k * time);
}

int main() {
    std::vector<MaterialConditionScenario> scenarios = {
        {"reference_cell_state", 0.86, 0.82, 0.84, 0.80, 0.78, 0.82, 0.18},
        {"dehydration_state", 0.34, 0.46, 0.68, 0.78, 0.72, 0.70, 0.58},
        {"hypoxic_state", 0.78, 0.74, 0.40, 0.32, 0.70, 0.68, 0.62},
        {"marine_acidification_state", 0.82, 0.70, 0.66, 0.72, 0.68, 0.38, 0.55},
        {"thermal_stress_state", 0.74, 0.70, 0.62, 0.68, 0.30, 0.66, 0.64},
        {"plant_drought_state", 0.38, 0.48, 0.58, 0.74, 0.66, 0.70, 0.60}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " material_condition_score=" << material_condition_score(scenario)
            << std::endl;
    }

    std::cout << "osmotic_pressure_atm=" << osmotic_pressure(1.0, 0.30, 0.082057, 298.0) << std::endl;
    std::cout << "homeostatic_state_t5=" << homeostatic_state(5.0, 10.0, 2.0, 0.4) << std::endl;

    return 0;
}
