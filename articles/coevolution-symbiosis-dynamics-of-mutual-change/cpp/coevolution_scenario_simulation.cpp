/*
 * Comparative coevolution scenario simulation in C++.
 */

#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    double stress;
    double baseline;
    double benefit_intercept;
    double benefit_stress_slope;
    double cost_intercept;
    double cost_stress_slope;
    double symbiont_load;
};

std::string relationship_state(double net_effect) {
    if (net_effect > 0.05) {
        return "beneficial";
    }

    if (net_effect >= -0.05) {
        return "near_neutral";
    }

    return "costly";
}

int main() {
    std::vector<Scenario> scenarios = {
        {"low_stress_mutualism", 0.10, 1.0, 0.8, 0.3, 0.2, 0.4, 0.75},
        {"moderate_stress_threshold", 0.55, 1.0, 0.8, 0.3, 0.2, 0.4, 0.75},
        {"high_stress_breakdown", 0.90, 1.0, 0.8, 0.3, 0.2, 0.4, 0.75},
        {"low_partner_load", 0.40, 1.0, 0.8, 0.3, 0.2, 0.4, 0.25}
    };

    for (const auto& scenario : scenarios) {
        double benefit = scenario.benefit_intercept - scenario.benefit_stress_slope * scenario.stress;
        double cost = scenario.cost_intercept + scenario.cost_stress_slope * scenario.stress;
        double net = scenario.symbiont_load * (benefit - cost);
        double host_net_performance = scenario.baseline + net;

        std::cout
            << "scenario=" << scenario.name
            << " stress=" << scenario.stress
            << " net_effect=" << net
            << " host_net_performance=" << host_net_performance
            << " relationship_state=" << relationship_state(net)
            << std::endl;
    }

    return 0;
}
