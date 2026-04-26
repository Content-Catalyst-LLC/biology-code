/*
 * Comparative regulatory scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct RegulatoryScenario {
    std::string name;
    double kon;
    double koff;
    double alpha_on;
    double alpha_off;
    double beta;
    double p_on0;
    double expression0;
};

double steady_state_p_on(double kon, double koff) {
    return kon / (kon + koff);
}

double steady_state_expression(double p_on, double alpha_on, double alpha_off, double beta) {
    double alpha = alpha_on * p_on + alpha_off * (1.0 - p_on);
    return alpha / beta;
}

int main() {
    std::vector<RegulatoryScenario> scenarios = {
        {"baseline_activation", 0.28, 0.10, 14.0, 1.0, 0.35, 0.05, 2.0},
        {"stable_activation", 0.40, 0.05, 12.0, 1.0, 0.25, 0.10, 2.0},
        {"transient_low_activation", 0.14, 0.20, 10.0, 1.0, 0.40, 0.05, 2.0}
    };

    for (const auto& scenario : scenarios) {
        double p_on = steady_state_p_on(scenario.kon, scenario.koff);
        double expression = steady_state_expression(
            p_on,
            scenario.alpha_on,
            scenario.alpha_off,
            scenario.beta
        );

        std::cout
            << "scenario=" << scenario.name
            << " p_on_ss=" << p_on
            << " expression_ss=" << expression
            << std::endl;
    }

    return 0;
}
