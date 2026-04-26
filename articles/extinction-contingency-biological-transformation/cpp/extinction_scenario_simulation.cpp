/*
 * Comparative extinction scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Clade {
    std::string name;
    double initial;
    double survivors;
};

struct RecoveryScenario {
    std::string name;
    double n0;
    double r;
    double k;
    double time;
};

double recovery(double n0, double r, double k, double time) {
    return k / (1.0 + ((k - n0) / n0) * std::exp(-r * time));
}

int main() {
    std::vector<Clade> clades = {
        {"clade_A", 120.0, 30.0},
        {"clade_B", 80.0, 40.0},
        {"clade_C", 50.0, 10.0},
        {"clade_D", 200.0, 110.0},
        {"clade_E", 65.0, 12.0}
    };

    for (const auto& clade : clades) {
        double survivorship = clade.survivors / clade.initial;
        double extinction = 1.0 - survivorship;

        std::cout
            << "clade=" << clade.name
            << " survivorship=" << survivorship
            << " extinction=" << extinction
            << std::endl;
    }

    std::vector<RecoveryScenario> recoveries = {
        {"slow_recovery", 5.0, 0.08, 40.0, 30.0},
        {"moderate_recovery", 5.0, 0.14, 60.0, 30.0},
        {"rapid_recovery", 5.0, 0.22, 80.0, 30.0}
    };

    for (const auto& scenario : recoveries) {
        std::cout
            << "scenario=" << scenario.name
            << " final_richness=" << recovery(scenario.n0, scenario.r, scenario.k, scenario.time)
            << std::endl;
    }

    return 0;
}
