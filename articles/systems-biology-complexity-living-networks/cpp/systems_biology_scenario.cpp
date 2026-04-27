/*
 * Scenario-based systems biology implementation in C++.
 */

#include <algorithm>
#include <cmath>
#include <iostream>
#include <string>
#include <tuple>
#include <vector>

struct FeedbackScenario {
    std::string name;
    double x0;
    double y0;
    double production_x;
    double production_y;
    double degradation_x;
    double degradation_y;
    double hill_n;
    double dt;
    int steps;
};

std::tuple<double, double> simulate_feedback(const FeedbackScenario& scenario) {
    double x = scenario.x0;
    double y = scenario.y0;

    for (int step = 0; step < scenario.steps; step++) {
        double dx = scenario.production_x / (1.0 + std::pow(y, scenario.hill_n)) - scenario.degradation_x * x;
        double dy = scenario.production_y * x - scenario.degradation_y * y;

        x = std::max(x + scenario.dt * dx, 0.0);
        y = std::max(y + scenario.dt * dy, 0.0);
    }

    return {x, y};
}

int main() {
    std::vector<FeedbackScenario> scenarios = {
        {"baseline_feedback", 0.20, 0.10, 1.20, 0.80, 0.40, 0.30, 2.0, 0.10, 80},
        {"strong_feedback", 0.20, 0.10, 1.20, 1.10, 0.40, 0.30, 3.0, 0.10, 80},
        {"weak_feedback", 0.20, 0.10, 1.20, 0.50, 0.40, 0.30, 1.0, 0.10, 80}
    };

    for (const auto& scenario : scenarios) {
        auto [x, y] = simulate_feedback(scenario);

        std::cout
            << "scenario=" << scenario.name
            << " final_x=" << x
            << " final_y=" << y
            << std::endl;
    }

    return 0;
}
