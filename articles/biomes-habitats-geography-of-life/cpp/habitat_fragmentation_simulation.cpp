/*
 * Habitat fragmentation simulation in C++.
 *
 * This compact example estimates expected richness before and after
 * fragmentation using S = c * A^z across multiple patches.
 */

#include <cmath>
#include <iostream>
#include <vector>

struct Patch {
    std::string id;
    double area;
};

double expected_richness(double c, double z, double area) {
    return c * std::pow(area, z);
}

int main() {
    const double c = 10.0;
    const double z = 0.25;
    const double area_multiplier_after_fragmentation = 0.70;

    std::vector<Patch> patches = {
        {"P1", 1.2},
        {"P2", 2.3},
        {"P3", 3.1},
        {"P4", 4.8},
        {"P5", 6.2},
        {"P6", 8.5},
        {"P7", 10.1},
        {"P8", 14.8},
        {"P9", 19.5},
        {"P10", 26.0}
    };

    for (const auto& patch : patches) {
        double baseline = expected_richness(c, z, patch.area);
        double fragmented = expected_richness(
            c,
            z,
            patch.area * area_multiplier_after_fragmentation
        );

        std::cout
            << "patch=" << patch.id
            << " baseline=" << baseline
            << " fragmented=" << fragmented
            << " expected_loss=" << baseline - fragmented
            << std::endl;
    }

    return 0;
}
