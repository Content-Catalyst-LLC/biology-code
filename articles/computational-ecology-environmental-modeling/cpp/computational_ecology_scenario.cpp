/*
 * Scenario-based computational ecology implementation in C++.
 */

#include <algorithm>
#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Site {
    std::string site_id;
    double temperature_c;
    double precipitation_mm;
    double habitat_quality;
    double disturbance;
};

double logistic(double x) {
    return 1.0 / (1.0 + std::exp(-x));
}

double habitat_suitability(const Site& site) {
    double score = -2.0
        + 0.05 * site.temperature_c
        + 0.0015 * site.precipitation_mm
        + 2.4 * site.habitat_quality
        - 2.0 * site.disturbance;

    return logistic(score);
}

double patch_occupancy(double initial_occupancy, double colonization, double extinction, int steps) {
    double occupancy = initial_occupancy;

    for (int step = 0; step < steps; step++) {
        occupancy = occupancy * (1.0 - extinction) + (1.0 - occupancy) * colonization;
        occupancy = std::clamp(occupancy, 0.0, 1.0);
    }

    return occupancy;
}

int main() {
    std::vector<Site> sites = {
        {"site_A", 16.2, 820.0, 0.82, 0.18},
        {"site_B", 22.5, 640.0, 0.64, 0.35},
        {"site_C", 28.1, 410.0, 0.31, 0.72}
    };

    for (const auto& site : sites) {
        std::cout
            << "site_id=" << site.site_id
            << " suitability=" << habitat_suitability(site)
            << std::endl;
    }

    std::cout << "baseline_final_occupancy=" << patch_occupancy(0.42, 0.12, 0.08, 30) << std::endl;

    return 0;
}
