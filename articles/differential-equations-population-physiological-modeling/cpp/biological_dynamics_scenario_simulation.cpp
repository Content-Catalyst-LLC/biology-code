/*
 * Comparative biological dynamics scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct LogisticScenario {
    std::string name;
    double n0;
    double r;
    double k;
};

double logistic_final(double n0, double r, double k, double dt, double t_end) {
    int steps = static_cast<int>(std::floor(t_end / dt)) + 1;
    double n = n0;

    for (int i = 1; i < steps; i++) {
        double dn = r * n * (1.0 - n / k);
        n = std::max(n + dn * dt, 0.0);
    }

    return n;
}

int main() {
    std::vector<LogisticScenario> scenarios = {
        {"baseline", 100.0, 0.30, 2000.0},
        {"resource_limited", 100.0, 0.18, 900.0},
        {"rapid_growth", 100.0, 0.45, 2600.0},
        {"low_capacity", 100.0, 0.30, 600.0}
    };

    for (const auto& scenario : scenarios) {
        double final_population = logistic_final(scenario.n0, scenario.r, scenario.k, 0.05, 40.0);

        std::cout
            << "scenario=" << scenario.name
            << " final_population=" << final_population
            << " fraction_capacity=" << final_population / scenario.k
            << std::endl;
    }

    return 0;
}
