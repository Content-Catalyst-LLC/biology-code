/*
 * Mycelial network efficiency simulation in C++.
 *
 * This compact example compares global efficiency before and after a
 * central connection in a mycelial transport network is removed.
 */

#include <algorithm>
#include <cmath>
#include <iostream>
#include <vector>

double global_efficiency(std::vector<std::vector<double>> adjacency) {
    const double inf = 1e9;
    const int n = static_cast<int>(adjacency.size());

    std::vector<std::vector<double>> dist(n, std::vector<double>(n, inf));

    for (int i = 0; i < n; ++i) {
        dist[i][i] = 0.0;

        for (int j = 0; j < n; ++j) {
            if (adjacency[i][j] > 0.0) {
                dist[i][j] = adjacency[i][j];
            }
        }
    }

    for (int k = 0; k < n; ++k) {
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                dist[i][j] = std::min(dist[i][j], dist[i][k] + dist[k][j]);
            }
        }
    }

    double total = 0.0;

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (i != j && dist[i][j] < inf) {
                total += 1.0 / dist[i][j];
            }
        }
    }

    return total / (n * (n - 1));
}

int main() {
    std::vector<std::vector<double>> adjacency = {
        {0, 1, 2, 0, 0, 0},
        {1, 0, 1, 2, 0, 0},
        {2, 1, 0, 1, 2, 0},
        {0, 2, 1, 0, 1, 2},
        {0, 0, 2, 1, 0, 1},
        {0, 0, 0, 2, 1, 0}
    };

    double baseline = global_efficiency(adjacency);

    std::vector<std::vector<double>> damaged = adjacency;
    damaged[2][3] = 0.0;
    damaged[3][2] = 0.0;

    double damaged_efficiency = global_efficiency(damaged);
    double percent_decline = 100.0 * (baseline - damaged_efficiency) / baseline;

    std::cout << "baseline_efficiency=" << baseline << std::endl;
    std::cout << "damaged_efficiency=" << damaged_efficiency << std::endl;
    std::cout << "percent_decline=" << percent_decline << std::endl;

    return 0;
}
