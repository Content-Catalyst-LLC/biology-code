/*
 * Comparative biological regulation scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct HillScenario {
    std::string name;
    double k_half;
    double hill_coefficient;
};

double hill_response(double signal, double k_half, double n) {
    return std::pow(signal, n) / (std::pow(k_half, n) + std::pow(signal, n));
}

double negative_feedback_final(double x0, double set_point, double k, double dt, double t_end) {
    int steps = static_cast<int>(std::floor(t_end / dt)) + 1;
    double x = x0;

    for (int i = 1; i < steps; i++) {
        double dx = -k * (x - set_point);
        x += dx * dt;
    }

    return x;
}

int main() {
    std::vector<HillScenario> scenarios = {
        {"linear_like", 40.0, 1.0},
        {"moderate_cooperativity", 40.0, 2.0},
        {"sharp_threshold", 40.0, 4.0},
        {"ultrasensitive", 40.0, 8.0}
    };

    for (const auto& scenario : scenarios) {
        std::cout
            << "scenario=" << scenario.name
            << " response_at_20=" << hill_response(20.0, scenario.k_half, scenario.hill_coefficient)
            << " response_at_40=" << hill_response(40.0, scenario.k_half, scenario.hill_coefficient)
            << " response_at_60=" << hill_response(60.0, scenario.k_half, scenario.hill_coefficient)
            << std::endl;
    }

    std::cout << "negative_feedback_final=" << negative_feedback_final(180.0, 100.0, 0.18, 0.05, 30.0) << std::endl;

    return 0;
}
