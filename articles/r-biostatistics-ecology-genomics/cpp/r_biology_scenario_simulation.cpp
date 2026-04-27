/*
 * Comparative R biology scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

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

double shannon_diversity(const std::vector<double>& counts) {
    double total = 0.0;

    for (double count : counts) {
        if (count > 0.0) {
            total += count;
        }
    }

    double h = 0.0;

    for (double count : counts) {
        if (count > 0.0) {
            double p = count / total;
            h += -p * std::log(p);
        }
    }

    return h;
}

int main() {
    std::vector<double> control = {10.2, 10.5, 10.1, 10.4, 10.3, 10.6};
    std::vector<double> treated = {12.1, 12.4, 11.9, 12.0, 12.5};
    std::vector<double> counts = {18.0, 7.0, 3.0, 0.0};

    std::cout << "control_mean=" << mean(control) << std::endl;
    std::cout << "treated_mean=" << mean(treated) << std::endl;
    std::cout << "control_sd=" << sample_sd(control) << std::endl;
    std::cout << "shannon_diversity=" << shannon_diversity(counts) << std::endl;

    return 0;
}
