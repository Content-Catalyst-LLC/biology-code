/*
 * Comparative selection scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    double p0;
    double w_AA;
    double w_Aa;
    double w_aa;
};

double mean_fitness(double p, double w_AA, double w_Aa, double w_aa) {
    double q = 1.0 - p;
    return p * p * w_AA + 2.0 * p * q * w_Aa + q * q * w_aa;
}

double selection_update(double p, double w_AA, double w_Aa, double w_aa) {
    double q = 1.0 - p;
    double wbar = mean_fitness(p, w_AA, w_Aa, w_aa);
    return (p * p * w_AA + p * q * w_Aa) / wbar;
}

int main() {
    std::vector<Scenario> scenarios = {
        {"directional_for_A", 0.20, 1.15, 1.08, 1.00},
        {"heterozygote_advantage", 0.20, 0.90, 1.00, 0.80},
        {"heterozygote_disadvantage", 0.50, 1.00, 0.70, 0.95},
        {"purifying_against_A", 0.70, 0.75, 0.92, 1.00}
    };

    for (const auto& scenario : scenarios) {
        double p_next = selection_update(scenario.p0, scenario.w_AA, scenario.w_Aa, scenario.w_aa);

        std::cout
            << "scenario=" << scenario.name
            << " p_initial=" << scenario.p0
            << " p_next=" << p_next
            << " delta_p=" << p_next - scenario.p0
            << " mean_fitness=" << mean_fitness(scenario.p0, scenario.w_AA, scenario.w_Aa, scenario.w_aa)
            << std::endl;
    }

    return 0;
}
