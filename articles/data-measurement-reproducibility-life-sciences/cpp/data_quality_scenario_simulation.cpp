/*
 * Comparative data-quality scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    std::vector<double> values;
    int total_records;
    int missing_records;
    int passing_records;
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
        {"baseline", {10.2, 10.5, 10.1, 10.4, 10.8, 10.7, 10.6, 10.3, 10.9, 10.4}, 12, 1, 10},
        {"high_missingness", {10.2, 10.5, 10.1, 10.4, 10.8, 10.7, 10.6, 10.3}, 12, 4, 8}
    };

    for (const auto& scenario : scenarios) {
        double m = mean(scenario.values);
        double sd = sample_sd(scenario.values);
        double cv = sd / m;
        double completeness = 1.0 - static_cast<double>(scenario.missing_records) / scenario.total_records;
        double pass_rate = static_cast<double>(scenario.passing_records) / scenario.total_records;

        std::cout
            << "scenario=" << scenario.name
            << " mean=" << m
            << " sd=" << sd
            << " cv=" << cv
            << " completeness=" << completeness
            << " qc_pass_rate=" << pass_rate
            << std::endl;
    }

    return 0;
}
