/*
 * Patch-based metapopulation simulation in C++.
 *
 * This compact example models occupancy changes across habitat patches using
 * patch quality, source occupancy, and distance-sensitive colonization.
 */

#include <cmath>
#include <iostream>
#include <random>
#include <vector>

struct Patch {
    double quality;
    double nearest_neighbor_km;
    bool occupied;
};

int main() {
    std::vector<Patch> patches = {
        {0.82, 2.4, true},
        {0.55, 4.8, false},
        {0.91, 3.1, true},
        {0.40, 8.6, false},
        {0.68, 2.9, true},
        {0.61, 5.3, false}
    };

    const int years = 40;
    const double base_colonization = 0.35;
    const double base_extinction = 0.12;

    std::mt19937 rng(42);
    std::uniform_real_distribution<double> uniform(0.0, 1.0);

    for (int year = 0; year < years; ++year) {
        int occupied_count = 0;
        for (const auto& patch : patches) {
            if (patch.occupied) occupied_count++;
        }

        double source_fraction = static_cast<double>(occupied_count) / patches.size();

        for (auto& patch : patches) {
            double colonization_probability =
                base_colonization * source_fraction * patch.quality *
                std::exp(-0.08 * patch.nearest_neighbor_km);

            double extinction_probability =
                base_extinction * (1.0 - patch.quality) +
                0.03 * patch.nearest_neighbor_km / 10.0;

            if (patch.occupied) {
                patch.occupied = uniform(rng) > extinction_probability;
            } else {
                patch.occupied = uniform(rng) < colonization_probability;
            }
        }
    }

    int final_occupied = 0;
    for (const auto& patch : patches) {
        if (patch.occupied) final_occupied++;
    }

    std::cout << "final_occupied_patches=" << final_occupied << std::endl;

    return 0;
}
