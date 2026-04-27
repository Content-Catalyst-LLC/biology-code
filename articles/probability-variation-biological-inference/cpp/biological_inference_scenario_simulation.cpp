/*
 * Comparative biological inference scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct TrialScenario {
    std::string name;
    double successes;
    double trials;
};

double binomial_log_likelihood(double successes, double trials, double p) {
    if (p <= 0.0 || p >= 1.0) return -INFINITY;
    double failures = trials - successes;
    return successes * std::log(p) + failures * std::log(1.0 - p);
}

int main() {
    std::vector<TrialScenario> scenarios = {
        {"germination_assay", 68, 100},
        {"infection_challenge", 37, 80},
        {"diagnostic_assay", 92, 120},
        {"restoration_survival", 41, 75},
        {"marine_detection", 24, 60}
    };

    for (const auto& scenario : scenarios) {
        double estimate = scenario.successes / scenario.trials;
        double se = std::sqrt(estimate * (1.0 - estimate) / scenario.trials);

        double best_p = 0.0;
        double best_ll = -INFINITY;

        for (int i = 1; i <= 99; i++) {
            double p = i / 100.0;
            double ll = binomial_log_likelihood(scenario.successes, scenario.trials, p);
            if (ll > best_ll) {
                best_ll = ll;
                best_p = p;
            }
        }

        std::cout
            << "scenario=" << scenario.name
            << " estimate=" << estimate
            << " standard_error=" << se
            << " best_likelihood_p=" << best_p
            << " best_log_likelihood=" << best_ll
            << std::endl;
    }

    return 0;
}
