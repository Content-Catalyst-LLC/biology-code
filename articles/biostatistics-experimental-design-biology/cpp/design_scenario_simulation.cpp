/*
 * Comparative experimental-design scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

struct GroupComparison {
    std::string name;
    std::vector<double> control;
    std::vector<double> treated;
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
    std::vector<GroupComparison> comparisons = {
        {
            "assay_response",
            {10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4},
            {12.1, 11.7, 12.4, 11.9, 12.0, 12.6, 11.8, 12.3}
        }
    };

    for (const auto& comparison : comparisons) {
        double mean0 = mean(comparison.control);
        double mean1 = mean(comparison.treated);
        double sd0 = sample_sd(comparison.control);
        double sd1 = sample_sd(comparison.treated);

        double n0 = static_cast<double>(comparison.control.size());
        double n1 = static_cast<double>(comparison.treated.size());

        double pooled_sd = std::sqrt(((n0 - 1.0) * sd0 * sd0 + (n1 - 1.0) * sd1 * sd1) / (n0 + n1 - 2.0));
        double difference = mean1 - mean0;
        double effect_size_d = difference / pooled_sd;
        double se_difference = std::sqrt(sd0 * sd0 / n0 + sd1 * sd1 / n1);

        std::cout
            << "comparison=" << comparison.name
            << " control_mean=" << mean0
            << " treated_mean=" << mean1
            << " difference=" << difference
            << " effect_size_d=" << effect_size_d
            << " se_difference=" << se_difference
            << std::endl;
    }

    return 0;
}
