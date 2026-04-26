/*
 * Comparative regulatory scenario simulation in C++.
 *
 * This compact example compares physiological feedback regimes across weak,
 * moderate, strong, stressed, and impaired-effector scenarios.
 */

#include <algorithm>
#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    double X0;
    double X_star;
    double input_rate;
    double a;
    double b;
    double c;
    double d;
    double u0;
    double u1;
};

struct Result {
    double final_X;
    double peak_X;
    double peak_H;
    double peak_E;
    double recovery_error;
};

Result simulate(const Scenario& s) {
    const double dt = 0.05;
    const int n_steps = 801;

    double X = s.X0;
    double H = 0.0;
    double E = 0.0;

    Result result;
    result.peak_X = X;
    result.peak_H = H;
    result.peak_E = E;

    for (int step = 1; step < n_steps; ++step) {
        double uptake = s.u0 + s.u1 * H * X;

        double dX = s.input_rate - uptake;
        double dH = s.a * (X - s.X_star) - s.b * H;
        double dE = s.c * H - s.d * E;

        X = std::max(0.0, X + dX * dt);
        H = std::max(0.0, H + dH * dt);
        E = std::max(0.0, E + dE * dt);

        result.peak_X = std::max(result.peak_X, X);
        result.peak_H = std::max(result.peak_H, H);
        result.peak_E = std::max(result.peak_E, E);
    }

    result.final_X = X;
    result.recovery_error = std::fabs(X - s.X_star);

    return result;
}

std::string regulatory_class(double recovery_error) {
    if (recovery_error < 0.5) {
        return "well-regulated";
    }

    if (recovery_error < 1.5) {
        return "strained";
    }

    return "poorly-regulated";
}

int main() {
    std::vector<Scenario> scenarios = {
        {"weak_feedback", 10.0, 5.0, 0.6, 0.5, 0.5, 0.7, 0.4, 0.3, 0.15},
        {"moderate_feedback", 10.0, 5.0, 0.6, 0.9, 0.5, 0.7, 0.4, 0.3, 0.25},
        {"strong_feedback", 10.0, 5.0, 0.6, 1.3, 0.6, 0.8, 0.4, 0.3, 0.35},
        {"stress_high_input", 10.0, 5.0, 0.9, 0.9, 0.5, 0.7, 0.4, 0.3, 0.25},
        {"weak_effector", 10.0, 5.0, 0.6, 0.9, 0.5, 0.7, 0.4, 0.3, 0.12}
    };

    for (const auto& scenario : scenarios) {
        Result result = simulate(scenario);

        std::cout
            << "scenario=" << scenario.name
            << " peak_X=" << result.peak_X
            << " peak_H=" << result.peak_H
            << " peak_E=" << result.peak_E
            << " final_X=" << result.final_X
            << " recovery_error=" << result.recovery_error
            << " regulatory_class=" << regulatory_class(result.recovery_error)
            << std::endl;
    }

    return 0;
}
