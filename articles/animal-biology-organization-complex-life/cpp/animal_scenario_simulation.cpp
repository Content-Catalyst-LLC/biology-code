/*
 * Comparative animal scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Species {
    std::string name;
    double mass_kg;
    std::string habitat;
    double exposure_risk;
};

int main() {
    const double B0 = 4.2;

    std::vector<Species> species = {
        {"shrew", 0.01, "terrestrial", 0.40},
        {"sparrow", 0.03, "terrestrial", 0.42},
        {"rabbit", 1.5, "terrestrial", 0.38},
        {"fox", 6.0, "terrestrial", 0.44},
        {"deer", 80.0, "terrestrial", 0.48},
        {"seal", 150.0, "marine", 0.55}
    };

    for (const auto& animal : species) {
        double metabolic_rate = B0 * std::pow(animal.mass_kg, 0.75);
        double mass_specific_rate = metabolic_rate / animal.mass_kg;

        std::cout
            << "species=" << animal.name
            << " mass_kg=" << animal.mass_kg
            << " metabolic_rate=" << metabolic_rate
            << " mass_specific_rate=" << mass_specific_rate
            << " exposure_risk=" << animal.exposure_risk
            << std::endl;
    }

    double juveniles = 40.0;
    double adults = 25.0;

    for (int year = 0; year <= 20; ++year) {
        std::cout
            << "year=" << year
            << " juveniles=" << juveniles
            << " adults=" << adults
            << " total=" << juveniles + adults
            << std::endl;

        double new_juveniles = 1.4 * adults;
        double new_adults = 0.35 * juveniles + 0.72 * adults;

        juveniles = new_juveniles;
        adults = new_adults;
    }

    return 0;
}
