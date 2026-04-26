/*
 * Site-by-species diversity and turnover simulation in C++.
 *
 * This compact example calculates Shannon diversity for each site and
 * Bray-Curtis dissimilarity for a pair of sites.
 */

#include <cmath>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

double shannon_diversity(const std::vector<double>& counts) {
    double total = std::accumulate(counts.begin(), counts.end(), 0.0);

    if (total <= 0.0) {
        return 0.0;
    }

    double shannon = 0.0;

    for (double count : counts) {
        if (count > 0.0) {
            double p = count / total;
            shannon -= p * std::log(p);
        }
    }

    return shannon;
}

double bray_curtis(const std::vector<double>& a, const std::vector<double>& b) {
    double numerator = 0.0;
    double denominator = 0.0;

    for (std::size_t i = 0; i < a.size(); ++i) {
        numerator += std::abs(a[i] - b[i]);
        denominator += a[i] + b[i];
    }

    if (denominator <= 0.0) {
        return 0.0;
    }

    return numerator / denominator;
}

int main() {
    std::vector<std::string> site_names = {"site_A", "site_B", "site_C", "site_D"};

    std::vector<std::vector<double>> community = {
        {12, 8, 0, 5, 3},
        {4, 10, 6, 0, 2},
        {0, 2, 9, 7, 8},
        {6, 1, 3, 12, 4}
    };

    for (std::size_t i = 0; i < community.size(); ++i) {
        double shannon = shannon_diversity(community[i]);
        std::cout
            << "site=" << site_names[i]
            << " shannon=" << shannon
            << " hill_q1=" << std::exp(shannon)
            << std::endl;
    }

    std::cout
        << "bray_curtis_site_A_site_B="
        << bray_curtis(community[0], community[1])
        << std::endl;

    return 0;
}
