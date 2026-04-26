/*
 * Comparative cell-condition scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct CellCondition {
    std::string name;
    double membrane_integrity;
    double metabolic_activity;
    double proliferation_capacity;
    double genomic_stability;
    double organelle_function;
    double stress_penalty;
};

double cell_condition_score(const CellCondition& item) {
    return 0.18 * item.membrane_integrity
        + 0.22 * item.metabolic_activity
        + 0.18 * item.proliferation_capacity
        + 0.17 * item.genomic_stability
        + 0.15 * item.organelle_function
        + 0.10 * (1.0 - item.stress_penalty);
}

std::string condition_class(double score) {
    if (score >= 0.75) {
        return "strong_cell_condition";
    }
    if (score >= 0.50) {
        return "moderate_cell_condition";
    }
    return "constrained_cell_condition";
}

double logistic_growth(double time, double initial_count, double growth_rate, double carrying_capacity) {
    return carrying_capacity / (1.0 + ((carrying_capacity - initial_count) / initial_count) * std::exp(-growth_rate * time));
}

int main() {
    std::vector<CellCondition> cases = {
        {"control", 0.92, 0.88, 0.84, 0.90, 0.86, 0.12},
        {"nutrient_limited", 0.78, 0.55, 0.48, 0.82, 0.70, 0.42},
        {"hypoxic", 0.70, 0.46, 0.42, 0.76, 0.52, 0.55},
        {"drug_treated", 0.62, 0.40, 0.30, 0.68, 0.48, 0.68},
        {"membrane_stress", 0.38, 0.54, 0.44, 0.74, 0.60, 0.64},
        {"mitochondrial_stress", 0.74, 0.36, 0.40, 0.72, 0.32, 0.70}
    };

    for (const auto& item : cases) {
        double score = cell_condition_score(item);
        std::cout
            << "condition=" << item.name
            << " cell_condition_score=" << score
            << " condition_class=" << condition_class(score)
            << std::endl;
    }

    std::cout << "logistic_growth_96h=" << logistic_growth(96.0, 1.0e5, 0.035, 1.0e6) << std::endl;

    return 0;
}
