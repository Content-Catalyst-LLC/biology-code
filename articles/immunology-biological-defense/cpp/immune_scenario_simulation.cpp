/*
 * Comparative immune scenario simulation in C++.
 *
 * This compact example compares pathogen, immune, and damage trajectories
 * across several parameter scenarios.
 */

#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    double P0;
    double I0;
    double D0;
    double r;
    double c;
    double alpha;
    double delta;
    double gamma;
    double rho;
};

struct Result {
    double final_pathogen;
    double final_immune;
    double final_damage;
    double peak_pathogen;
    double peak_immune;
    double peak_damage;
};

Result simulate(const Scenario& s) {
    const double dt = 0.05;
    const int n_steps = 601;

    double pathogen = s.P0;
    double immune = s.I0;
    double damage = s.D0;

    Result result;
    result.peak_pathogen = pathogen;
    result.peak_immune = immune;
    result.peak_damage = damage;

    for (int step = 1; step < n_steps; ++step) {
        double d_pathogen = s.r * pathogen - s.c * immune * pathogen;
        double d_immune = s.alpha * pathogen - s.delta * immune;
        double d_damage = s.gamma * immune - s.rho * damage;

        pathogen = std::max(0.0, pathogen + d_pathogen * dt);
        immune = std::max(0.0, immune + d_immune * dt);
        damage = std::max(0.0, damage + d_damage * dt);

        result.peak_pathogen = std::max(result.peak_pathogen, pathogen);
        result.peak_immune = std::max(result.peak_immune, immune);
        result.peak_damage = std::max(result.peak_damage, damage);
    }

    result.final_pathogen = pathogen;
    result.final_immune = immune;
    result.final_damage = damage;

    return result;
}

std::string risk_class(const Result& result) {
    if (result.peak_pathogen > 200.0 || result.peak_damage > 20.0) {
        return "high-risk";
    }

    if (result.peak_pathogen > 100.0 || result.peak_damage > 10.0) {
        return "stressed";
    }

    return "controlled";
}

int main() {
    std::vector<Scenario> scenarios = {
        {"weak_clearance", 50.0, 2.0, 0.0, 0.45, 0.08, 0.06, 0.18, 0.06, 0.10},
        {"moderate_clearance", 50.0, 2.0, 0.0, 0.45, 0.12, 0.08, 0.18, 0.06, 0.10},
        {"strong_clearance", 50.0, 2.0, 0.0, 0.45, 0.18, 0.10, 0.18, 0.06, 0.10},
        {"hyperinflammatory", 50.0, 2.0, 0.0, 0.45, 0.14, 0.12, 0.18, 0.12, 0.10},
        {"immune_suppressed", 50.0, 2.0, 0.0, 0.45, 0.06, 0.04, 0.24, 0.05, 0.10}
    };

    for (const auto& scenario : scenarios) {
        Result result = simulate(scenario);

        std::cout
            << "scenario=" << scenario.name
            << " peak_pathogen=" << result.peak_pathogen
            << " peak_damage=" << result.peak_damage
            << " final_pathogen=" << result.final_pathogen
            << " final_damage=" << result.final_damage
            << " risk_class=" << risk_class(result)
            << std::endl;
    }

    return 0;
}
