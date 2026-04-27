/*
 * Comparative biological modeling scenario implementation in C++.
 */

#include <algorithm>
#include <iostream>
#include <string>
#include <tuple>
#include <vector>

struct LogisticScenario {
    std::string name;
    double initial_population;
    double growth_rate;
    double carrying_capacity;
    double dt;
    int steps;
};

double logistic_growth(const LogisticScenario& scenario) {
    double population = scenario.initial_population;

    for (int step = 0; step < scenario.steps; step++) {
        double growth = scenario.growth_rate * population * (1.0 - population / scenario.carrying_capacity);
        population = std::max(population + scenario.dt * growth, 0.0);
    }

    return population;
}

std::tuple<double, double, double> two_compartment(double initial_a, double initial_b, double k_ab, double k_ba, double k_clear, double dt, int steps) {
    double amount_a = initial_a;
    double amount_b = initial_b;

    for (int step = 0; step < steps; step++) {
        double flow_ab = k_ab * amount_a;
        double flow_ba = k_ba * amount_b;
        double clearance = k_clear * amount_a;

        double next_a = std::max(amount_a + dt * (-flow_ab + flow_ba - clearance), 0.0);
        double next_b = std::max(amount_b + dt * (flow_ab - flow_ba), 0.0);

        amount_a = next_a;
        amount_b = next_b;
    }

    return {amount_a, amount_b, amount_a + amount_b};
}

int main() {
    std::vector<LogisticScenario> scenarios = {
        {"low_growth", 25.0, 0.15, 1000.0, 0.1, 200},
        {"baseline", 25.0, 0.35, 1000.0, 0.1, 200},
        {"high_growth", 25.0, 0.55, 1000.0, 0.1, 200}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " final_population=" << logistic_growth(scenario)
            << std::endl;
    }

    auto [a, b, total] = two_compartment(100.0, 0.0, 0.18, 0.07, 0.03, 0.1, 150);

    std::cout << "final_compartment_a=" << a << std::endl;
    std::cout << "final_compartment_b=" << b << std::endl;
    std::cout << "final_total_amount=" << total << std::endl;

    return 0;
}
