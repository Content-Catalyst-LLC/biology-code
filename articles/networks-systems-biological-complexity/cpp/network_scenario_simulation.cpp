/*
 * Comparative biological-network scenario simulation in C++.
 */

#include <algorithm>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

struct NetworkScenario {
    std::string name;
    std::vector<std::vector<double>> adjacency;
};

std::vector<int> degree(const std::vector<std::vector<double>>& adjacency) {
    std::vector<int> degrees(adjacency.size(), 0);

    for (std::size_t i = 0; i < adjacency.size(); i++) {
        for (double value : adjacency[i]) {
            if (value > 0.0) {
                degrees[i]++;
            }
        }
    }

    return degrees;
}

double density(const std::vector<std::vector<double>>& adjacency) {
    int n = static_cast<int>(adjacency.size());
    double edges = 0.0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (adjacency[i][j] > 0.0) {
                edges += 1.0;
            }
        }
    }

    double possible = static_cast<double>(n * (n - 1)) / 2.0;
    return edges / possible;
}

int main() {
    std::vector<NetworkScenario> scenarios = {
        {
            "synthetic_regulatory_network",
            {
                {0.0, 1.0, 0.8, 0.0, 0.0, 0.0},
                {1.0, 0.0, 0.7, 1.2, 0.0, 0.0},
                {0.8, 0.7, 0.0, 0.0, 0.9, 0.0},
                {0.0, 1.2, 0.0, 0.0, 1.1, 0.6},
                {0.0, 0.0, 0.9, 1.1, 0.0, 0.5},
                {0.0, 0.0, 0.0, 0.6, 0.5, 0.0}
            }
        }
    };

    for (const auto& scenario : scenarios) {
        auto degrees = degree(scenario.adjacency);
        double mean_degree = static_cast<double>(std::accumulate(degrees.begin(), degrees.end(), 0)) / degrees.size();
        int max_degree = *std::max_element(degrees.begin(), degrees.end());

        std::cout
            << "scenario=" << scenario.name
            << " density=" << density(scenario.adjacency)
            << " mean_degree=" << mean_degree
            << " max_degree=" << max_degree
            << std::endl;
    }

    return 0;
}
