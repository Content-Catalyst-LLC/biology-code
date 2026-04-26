/*
 * Comparative plant scenario simulation in C++.
 */

#include <iostream>
#include <string>
#include <vector>

struct Site {
    std::string name;
    double gpp;
    double ra;
    double rh;
};

double light_response(double irradiance, double alpha, double amax, double rd) {
    return (alpha * irradiance * amax) / (alpha * irradiance + amax) - rd;
}

int main() {
    std::vector<Site> sites = {
        {"temperate_forest", 2200.0, 900.0, 700.0},
        {"grassland", 1450.0, 600.0, 500.0},
        {"wetland", 1800.0, 760.0, 680.0},
        {"restoration_site", 1300.0, 620.0, 710.0}
    };

    for (const auto& site : sites) {
        double npp = site.gpp - site.ra;
        double nep = site.gpp - (site.ra + site.rh);

        std::cout
            << "site=" << site.name
            << " NPP=" << npp
            << " NEP=" << nep
            << std::endl;
    }

    std::cout
        << "reference_assimilation_at_1000="
        << light_response(1000.0, 0.055, 20.0, 1.5)
        << std::endl;

    return 0;
}
