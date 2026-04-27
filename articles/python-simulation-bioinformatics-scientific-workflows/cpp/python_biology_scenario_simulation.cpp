/*
 * Comparative biological simulation scenario in C++.
 */

#include <algorithm>
#include <cctype>
#include <iostream>
#include <string>
#include <vector>

double logistic_growth(double initial, double growth_rate, double carrying_capacity, double dt, int steps) {
    double population = initial;

    for (int step = 0; step <= steps; step++) {
        double growth = growth_rate * population * (1.0 - population / carrying_capacity);
        population = std::max(population + dt * growth, 0.0);
    }

    return population;
}

double gc_content(const std::string& sequence) {
    double valid = 0.0;
    double gc = 0.0;

    for (char c : sequence) {
        char base = static_cast<char>(std::toupper(c));

        if (base == 'A' || base == 'T') {
            valid += 1.0;
        } else if (base == 'G' || base == 'C') {
            valid += 1.0;
            gc += 1.0;
        }
    }

    if (valid == 0.0) {
        return 0.0;
    }

    return gc / valid;
}

int main() {
    std::vector<double> growth_rates = {0.18, 0.35, 0.50};

    for (double r : growth_rates) {
        std::cout
            << "growth_rate=" << r
            << " final_population=" << logistic_growth(25.0, r, 1000.0, 0.1, 200)
            << std::endl;
    }

    std::cout << "gc_content=" << gc_content("ATGCGCGTAATTAACCGGTTACCGTAGCTA") << std::endl;

    return 0;
}
