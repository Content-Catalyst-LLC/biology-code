/*
 * Comparative life-definition scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct BorderlineCase {
    std::string name;
    double organization;
    double metabolism;
    double autonomy;
    double heredity;
    double responsiveness;
    double evolutionary_capacity;
};

double heuristic_life_score(const BorderlineCase& item) {
    return 0.18 * item.organization
        + 0.18 * item.metabolism
        + 0.16 * item.autonomy
        + 0.18 * item.heredity
        + 0.12 * item.responsiveness
        + 0.18 * item.evolutionary_capacity;
}

std::string category(double score) {
    if (score >= 0.72) {
        return "strongly_life_like_under_this_matrix";
    }
    if (score >= 0.45) {
        return "borderline_or_context_dependent";
    }
    return "weakly_life_like_under_this_matrix";
}

double viability_decay(double time, double initial_count, double loss_rate) {
    return initial_count * std::exp(-loss_rate * time);
}

int main() {
    std::vector<BorderlineCase> cases = {
        {"bacterium", 0.95, 0.90, 0.88, 0.90, 0.85, 0.90},
        {"virus", 0.55, 0.05, 0.10, 0.82, 0.25, 0.88},
        {"dormant_seed", 0.80, 0.20, 0.45, 0.86, 0.40, 0.80},
        {"sterile_mule", 0.95, 0.88, 0.92, 0.80, 0.90, 0.20},
        {"fungal_spore", 0.82, 0.18, 0.50, 0.84, 0.38, 0.78},
        {"synthetic_cell_candidate", 0.70, 0.55, 0.50, 0.60, 0.45, 0.35},
        {"crystal", 0.35, 0.00, 0.00, 0.00, 0.05, 0.00}
    };

    for (const auto& item : cases) {
        double score = heuristic_life_score(item);
        std::cout
            << "case=" << item.name
            << " heuristic_life_score=" << score
            << " category=" << category(score)
            << std::endl;
    }

    double loss_rate = std::log(4.0) / 48.0;
    std::cout << "viable_count_48h=" << viability_decay(48.0, 1.0e6, loss_rate) << std::endl;

    return 0;
}
