/*
 * Comparative population-genetic scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    double p;
    double W_AA;
    double W_Aa;
    double W_aa;
    double mu;
    double nu;
    double m;
    double p_migrant;
};

double selection_update(double p, double W_AA, double W_Aa, double W_aa) {
    double q = 1.0 - p;
    double f_AA = p * p;
    double f_Aa = 2.0 * p * q;
    double f_aa = q * q;
    double Wbar = f_AA * W_AA + f_Aa * W_Aa + f_aa * W_aa;

    return (f_AA * W_AA + 0.5 * f_Aa * W_Aa) / Wbar;
}

int main() {
    std::vector<Scenario> scenarios = {
        {"neutral_large_pop", 0.50, 1.00, 1.00, 1.00, 0.0000, 0.0000, 0.000, 0.50},
        {"selection_for_A", 0.20, 1.15, 1.08, 1.00, 0.0000, 0.0000, 0.000, 0.50},
        {"migration_balance", 0.90, 1.00, 1.00, 1.00, 0.0000, 0.0000, 0.040, 0.15},
        {"mutation_selection_balance", 0.99, 1.00, 0.98, 0.92, 0.0015, 0.0001, 0.000, 0.50}
    };

    for (const auto& scenario : scenarios) {
        double p_selected = selection_update(scenario.p, scenario.W_AA, scenario.W_Aa, scenario.W_aa);
        double q_selected = 1.0 - p_selected;
        double p_mutated = p_selected * (1.0 - scenario.mu) + q_selected * scenario.nu;
        double p_migrated = (1.0 - scenario.m) * p_mutated + scenario.m * scenario.p_migrant;

        std::cout
            << "scenario=" << scenario.name
            << " p_initial=" << scenario.p
            << " p_after_selection=" << p_selected
            << " p_after_mutation=" << p_mutated
            << " p_after_migration=" << p_migrated
            << std::endl;
    }

    return 0;
}
