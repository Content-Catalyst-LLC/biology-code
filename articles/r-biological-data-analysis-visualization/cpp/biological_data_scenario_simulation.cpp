/*
 * Comparative biological data scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

struct Scenario {
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

int main() {
    std::vector<Scenario> scenarios = {
        {"control", {10.2, 10.5, 10.1, 10.4, 10.3, 10.6}},
        {"treated", {12.1, 12.4, 11.9, 12.5}}
    };

    for (const auto& scenario : scenarios) {
        double m = mean(scenario.values);
        double sd = sample_sd(scenario.values);

        std::cout
            << "scenario=" << scenario.name
            << " n=" << scenario.values.size()
            << " mean=" << m
            << " sd=" << sd
            << " cv=" << sd / m
            << std::endl;
    }

    return 0;
}
