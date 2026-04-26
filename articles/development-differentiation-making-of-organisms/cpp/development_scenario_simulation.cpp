/*
 * Comparative developmental scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct DevelopmentScenario {
    std::string name;
    double initial_cells;
    double growth_rate;
    double constraint;
    double k1;
    double k2;
};

double logistic_next(double N, double r, double K, double dt) {
    double dN = r * N * (1.0 - N / K);
    return N + dN * dt;
}

double lineage_one_fraction(double k1, double k2) {
    return k1 / (k1 + k2);
}

int main() {
    std::vector<DevelopmentScenario> scenarios = {
        {"reference_embryoid_system", 10000.0, 0.070, 62000.0, 0.14, 0.09},
        {"rapid_lineage1_commitment", 10000.0, 0.075, 65000.0, 0.20, 0.05},
        {"rapid_lineage2_commitment", 10000.0, 0.060, 58000.0, 0.07, 0.17},
        {"slow_commitment", 10000.0, 0.045, 50000.0, 0.06, 0.04}
    };

    for (const auto& scenario : scenarios) {
        double next_N = logistic_next(
            scenario.initial_cells,
            scenario.growth_rate,
            scenario.constraint,
            1.0
        );

        std::cout
            << "scenario=" << scenario.name
            << " next_cells=" << next_N
            << " lineage_1_fraction=" << lineage_one_fraction(scenario.k1, scenario.k2)
            << std::endl;
    }

    return 0;
}
