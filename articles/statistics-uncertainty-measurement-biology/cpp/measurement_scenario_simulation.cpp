/*
 * Comparative biological measurement scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

struct MeasurementScenario {
    std::string name;
    std::vector<double> values;
};

double mean(const std::vector<double>& values) {
    return std::accumulate(values.begin(), values.end(), 0.0) / values.size();
}

double sample_sd(const std::vector<double>& values) {
    double m = mean(values);
    double sumsq = 0.0;

    for (double value : values) {
        sumsq += std::pow(value - m, 2.0);
    }

    return std::sqrt(sumsq / (values.size() - 1));
}

double combined_uncertainty(const std::vector<double>& components) {
    double sumsq = 0.0;

    for (double u : components) {
        sumsq += u * u;
    }

    return std::sqrt(sumsq);
}

int main() {
    std::vector<MeasurementScenario> scenarios = {
        {"control", {10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4, 11.3, 10.7}},
        {"treated", {12.1, 11.7, 12.4, 11.9, 12.0, 12.6, 11.8, 12.3}}
    };

    for (const auto& scenario : scenarios) {
        double m = mean(scenario.values);
        double sd = sample_sd(scenario.values);
        double se = sd / std::sqrt(static_cast<double>(scenario.values.size()));

        std::cout
            << "scenario=" << scenario.name
            << " mean=" << m
            << " sd=" << sd
            << " se=" << se
            << " ci_lower=" << m - 1.96 * se
            << " ci_upper=" << m + 1.96 * se
            << std::endl;
    }

    std::vector<double> components = {0.12, 0.08, 0.15, 0.06, 0.05};
    double uc = combined_uncertainty(components);

    std::cout << "combined_standard_uncertainty=" << uc << std::endl;
    std::cout << "expanded_uncertainty=" << 2.0 * uc << std::endl;

    return 0;
}
