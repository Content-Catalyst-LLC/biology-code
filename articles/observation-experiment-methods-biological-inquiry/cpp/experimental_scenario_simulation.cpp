/*
 * Comparative experimental scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct SignalExperiment {
    std::string name;
    double signal_strength;
    double reproducibility;
    double control_separation;
    double noise_penalty;
};

double signal_quality_score(const SignalExperiment& e) {
    return 0.30 * e.signal_strength
        + 0.30 * e.reproducibility
        + 0.25 * e.control_separation
        - 0.15 * e.noise_penalty;
}

std::string signal_class(double score) {
    if (score >= 0.72) return "strong_signal";
    if (score >= 0.50) return "moderate_signal";
    return "weak_or_uncertain_signal";
}

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * std::exp(-r * t));
}

int main() {
    std::vector<SignalExperiment> experiments = {
        {"growth_assay_A", 0.86, 0.82, 0.78, 0.14},
        {"growth_assay_B", 0.70, 0.74, 0.62, 0.28},
        {"biosensor_A", 0.84, 0.80, 0.88, 0.18},
        {"field_monitoring_A", 0.62, 0.58, 0.54, 0.36}
    };

    for (const auto& e : experiments) {
        double score = signal_quality_score(e);
        std::cout
            << "experiment=" << e.name
            << " signal_quality_score=" << score
            << " signal_class=" << signal_class(score)
            << std::endl;
    }

    std::cout << "logistic_24=" << logistic_growth(24.0, 1.0e5, 0.45, 2.0e6) << std::endl;

    return 0;
}
