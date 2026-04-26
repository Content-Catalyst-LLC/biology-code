/*
 * Comparative speciation scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Case {
    std::string name;
    double p1;
    double p2;
    double lambda;
    double mu;
};

double fst_style(double p1, double p2) {
    double h1 = 2.0 * p1 * (1.0 - p1);
    double h2 = 2.0 * p2 * (1.0 - p2);
    double pbar = (p1 + p2) / 2.0;
    double ht = 2.0 * pbar * (1.0 - pbar);
    double hs = (h1 + h2) / 2.0;

    if (ht <= 0.0) {
        return 0.0;
    }

    return (ht - hs) / ht;
}

int main() {
    std::vector<Case> cases = {
        {"reference_pair", 0.70, 0.42, 0.10, 0.03},
        {"hybrid_zone", 0.58, 0.45, 0.07, 0.06},
        {"island_radiation", 0.80, 0.28, 0.14, 0.04},
        {"high_turnover", 0.66, 0.36, 0.14, 0.12}
    };

    for (const auto& item : cases) {
        double delta = std::abs(item.p1 - item.p2);
        double fst = fst_style(item.p1, item.p2);
        double net = item.lambda - item.mu;

        std::cout
            << "case=" << item.name
            << " delta_p=" << delta
            << " fst_style=" << fst
            << " net_diversification=" << net
            << std::endl;
    }

    return 0;
}
