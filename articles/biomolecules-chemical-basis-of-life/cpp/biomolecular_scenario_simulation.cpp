/*
 * Comparative biomolecular scenario simulation in C++.
 */

#include <iostream>
#include <string>
#include <vector>

struct BiomolecularScenario {
    std::string name;
    double carbohydrate_support;
    double lipid_boundary_function;
    double protein_function;
    double nucleic_acid_integrity;
    double metabolite_balance;
    double cofactor_availability;
    double stress_penalty;
};

double biomolecular_score(const BiomolecularScenario& s) {
    return 0.14 * s.carbohydrate_support
        + 0.15 * s.lipid_boundary_function
        + 0.18 * s.protein_function
        + 0.17 * s.nucleic_acid_integrity
        + 0.14 * s.metabolite_balance
        + 0.12 * s.cofactor_availability
        + 0.10 * (1.0 - s.stress_penalty);
}

double michaelis_menten(double substrate, double vmax, double km) {
    return (vmax * substrate) / (km + substrate);
}

double ligand_fraction_bound(double ligand, double kd) {
    return ligand / (kd + ligand);
}

int main() {
    std::vector<BiomolecularScenario> scenarios = {
        {"reference_cell_state", 0.84, 0.82, 0.86, 0.88, 0.80, 0.78, 0.18},
        {"energy_storage_deficit", 0.42, 0.76, 0.74, 0.82, 0.58, 0.70, 0.48},
        {"membrane_disruption_state", 0.72, 0.38, 0.68, 0.80, 0.62, 0.66, 0.60},
        {"protein_misfolding_state", 0.76, 0.72, 0.34, 0.82, 0.60, 0.58, 0.66},
        {"genomic_damage_state", 0.78, 0.74, 0.70, 0.36, 0.64, 0.62, 0.70},
        {"metabolic_cofactor_limited_state", 0.70, 0.72, 0.62, 0.78, 0.42, 0.30, 0.58}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " biomolecular_condition_score=" << biomolecular_score(scenario)
            << std::endl;
    }

    std::cout << "velocity=" << michaelis_menten(6.0, 100.0, 3.0) << std::endl;
    std::cout << "fraction_bound=" << ligand_fraction_bound(8.0, 8.0) << std::endl;

    return 0;
}
