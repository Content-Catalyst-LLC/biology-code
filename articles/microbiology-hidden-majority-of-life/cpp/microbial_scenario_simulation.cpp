/*
 * Comparative microbial scenario simulation in C++.
 *
 * This compact example compares Monod growth across environmental scenarios.
 */

#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    double N0;
    double S0;
    double mu_max;
    double Ks;
    double yield_coeff;
};

struct Result {
    double final_abundance;
    double remaining_substrate;
    double peak_abundance;
};

Result simulate_monod(const Scenario& s) {
    const double dt = 0.1;
    const int n_steps = 481;

    double abundance = s.N0;
    double substrate = s.S0;
    double peak_abundance = abundance;

    for (int step = 1; step < n_steps; ++step) {
        double mu = s.mu_max * substrate / (s.Ks + substrate);
        double d_abundance = mu * abundance * dt;
        double d_substrate = -(d_abundance / s.yield_coeff);

        abundance = std::max(0.0, abundance + d_abundance);
        substrate = std::max(0.0, substrate + d_substrate);
        peak_abundance = std::max(peak_abundance, abundance);
    }

    return {abundance, substrate, peak_abundance};
}

int main() {
    std::vector<Scenario> scenarios = {
        {"rich_media", 10000.0, 150.0, 0.9, 15.0, 1000000.0},
        {"poor_media", 10000.0, 50.0, 0.6, 25.0, 1000000.0},
        {"stress_condition", 10000.0, 50.0, 0.3, 30.0, 1000000.0}
    };

    for (const auto& scenario : scenarios) {
        Result result = simulate_monod(scenario);

        std::cout
            << "scenario=" << scenario.name
            << " final_abundance=" << result.final_abundance
            << " remaining_substrate=" << result.remaining_substrate
            << " peak_abundance=" << result.peak_abundance
            << std::endl;
    }

    return 0;
}
