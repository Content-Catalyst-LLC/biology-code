/*
 * Comparative evolutionary-scale scenario simulation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Clade {
    std::string name;
    double originations;
    double extinctions;
    double interval_myr;
};

double selection_update(double p, double w_AA, double w_Aa, double w_aa) {
    double q = 1.0 - p;
    double f_AA = p * p;
    double f_Aa = 2.0 * p * q;
    double f_aa = q * q;
    double wbar = f_AA * w_AA + f_Aa * w_Aa + f_aa * w_aa;

    return (f_AA * w_AA + 0.5 * f_Aa * w_Aa) / wbar;
}

int main() {
    double p = 0.8;
    double q = 1.0 - p;

    std::cout << "AA=" << p * p << " Aa=" << 2.0 * p * q << " aa=" << q * q << std::endl;
    std::cout << "selection_p_next=" << selection_update(0.2, 1.15, 1.08, 1.0) << std::endl;

    std::vector<Clade> clades = {
        {"Clade_A", 18.0, 7.0, 20.0},
        {"Clade_B", 9.0, 8.0, 20.0},
        {"Clade_C", 25.0, 10.0, 20.0},
        {"Clade_D", 12.0, 14.0, 20.0},
        {"Clade_E", 15.0, 5.0, 30.0}
    };

    for (const auto& clade : clades) {
        double lambda = clade.originations / clade.interval_myr;
        double mu = clade.extinctions / clade.interval_myr;
        double net = lambda - mu;

        std::cout
            << "clade=" << clade.name
            << " lambda=" << lambda
            << " mu=" << mu
            << " net_diversification=" << net
            << std::endl;
    }

    return 0;
}
