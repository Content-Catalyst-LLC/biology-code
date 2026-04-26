/*
 * Comparative modern-biology scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct SelectionScenario {
    std::string name;
    double p_initial;
    double w_AA;
    double w_Aa;
    double w_aa;
    int generations;
};

double selection_update(double p, double w_AA, double w_Aa, double w_aa) {
    double q = 1.0 - p;
    double wbar = p * p * w_AA + 2.0 * p * q * w_Aa + q * q * w_aa;
    return (p * p * w_AA + p * q * w_Aa) / wbar;
}

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * std::exp(-r * t));
}

int main() {
    std::vector<SelectionScenario> scenarios = {
        {"neutral", 0.50, 1.00, 1.00, 1.00, 20},
        {"directional_A", 0.50, 1.10, 1.05, 1.00, 20},
        {"heterozygote_advantage", 0.50, 0.90, 1.10, 0.90, 20},
        {"against_AA", 0.70, 0.80, 1.00, 1.00, 20}
    };

    for (const auto& scenario : scenarios) {
        double p = scenario.p_initial;

        for (int g = 0; g < scenario.generations; g++) {
            p = selection_update(p, scenario.w_AA, scenario.w_Aa, scenario.w_aa);
        }

        std::cout
            << "scenario=" << scenario.name
            << " final_p=" << p
            << std::endl;
    }

    std::cout << "logistic_20=" << logistic_growth(20.0, 100.0, 0.35, 2000.0) << std::endl;

    return 0;
}
