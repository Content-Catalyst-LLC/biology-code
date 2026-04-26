/*
 * Comparative cellular architecture scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct CellArchitectureScenario {
    std::string name;
    double membrane_integrity;
    double transport_capacity;
    double organelle_specialization;
    double trafficking_coordination;
    double energy_compartment_function;
    double turnover_capacity;
    double stress_penalty;
};

double cellular_architecture_score(const CellArchitectureScenario& s) {
    return 0.17 * s.membrane_integrity
        + 0.15 * s.transport_capacity
        + 0.14 * s.organelle_specialization
        + 0.15 * s.trafficking_coordination
        + 0.15 * s.energy_compartment_function
        + 0.14 * s.turnover_capacity
        + 0.10 * (1.0 - s.stress_penalty);
}

double sphere_surface_area(double radius) {
    return 4.0 * M_PI * radius * radius;
}

double sphere_volume(double radius) {
    return (4.0 / 3.0) * M_PI * radius * radius * radius;
}

int main() {
    std::vector<CellArchitectureScenario> scenarios = {
        {"reference_cell_state", 0.86, 0.82, 0.80, 0.78, 0.82, 0.76, 0.18},
        {"membrane_stress_state", 0.46, 0.52, 0.72, 0.60, 0.66, 0.64, 0.58},
        {"mitochondrial_dysfunction_state", 0.76, 0.70, 0.68, 0.62, 0.34, 0.58, 0.64},
        {"trafficking_defect_state", 0.74, 0.66, 0.70, 0.32, 0.62, 0.50, 0.52},
        {"plant_vacuolar_stress_state", 0.70, 0.76, 0.78, 0.68, 0.72, 0.82, 0.34},
        {"marine_osmotic_stress_state", 0.58, 0.48, 0.70, 0.62, 0.64, 0.60, 0.66}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " cellular_architecture_score=" << cellular_architecture_score(scenario)
            << std::endl;
    }

    double radius = 5.0;
    std::cout << "radius_um=" << radius << std::endl;
    std::cout << "surface_area_um2=" << sphere_surface_area(radius) << std::endl;
    std::cout << "volume_um3=" << sphere_volume(radius) << std::endl;
    std::cout << "sa_to_volume=" << sphere_surface_area(radius) / sphere_volume(radius) << std::endl;

    return 0;
}
