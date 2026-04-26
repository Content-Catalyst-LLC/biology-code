/*
 * Stage-structured life-cycle projection in C++.
 *
 * This compact example projects juveniles, subadults, and adults through
 * a fixed projection matrix.
 */

#include <array>
#include <iostream>

int main() {
    const int time_steps = 20;

    std::array<double, 3> n = {50.0, 20.0, 15.0};

    for (int t = 0; t < time_steps; ++t) {
        std::array<double, 3> next_n = {
            0.0 * n[0] + 0.0 * n[1] + 1.8 * n[2],
            0.45 * n[0] + 0.0 * n[1] + 0.0 * n[2],
            0.0 * n[0] + 0.70 * n[1] + 0.82 * n[2]
        };

        n = next_n;
    }

    double total = n[0] + n[1] + n[2];

    std::cout << "final_juvenile=" << n[0] << std::endl;
    std::cout << "final_subadult=" << n[1] << std::endl;
    std::cout << "final_adult=" << n[2] << std::endl;
    std::cout << "final_total=" << total << std::endl;

    return 0;
}
