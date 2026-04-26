/*
 * Comparative evolutionary scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct EvolutionScenario {
    std::string name;
    double p0;
    double w_AA;
    double w_Aa;
    double w_aa;
    double lambda;
    double mu;
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
    std::vector<EvolutionScenario> scenarios = {
        {"neutral_large_pop", 0.50, 1.00, 1.00, 1.00, 0.07, 0.06},
        {"positive_selection", 0.20, 1.12, 1.05, 1.00, 0.10, 0.03},
        {"migration_selection", 0.80, 1.08, 1.02, 1.00, 0.14, 0.12},
        {"mutation_selection_balance", 0.98, 1.00, 0.97, 0.90, 0.06, 0.11}
    };

    for (const auto& scenario : scenarios) {
        double p_next = selection_update(scenario.p0, scenario.w_AA, scenario.w_Aa, scenario.w_aa);
        double net = scenario.lambda - scenario.mu;

        std::cout
            << "scenario=" << scenario.name
            << " p_initial=" << scenario.p0
            << " p_next=" << p_next
            << " delta_p=" << p_next - scenario.p0
            << " mean_fitness=" << mean_fitness(scenario.p0, scenario.w_AA, scenario.w_Aa, scenario.w_aa)
            << " net_diversification=" << net
            << std::endl;
    }

    return 0;
}
