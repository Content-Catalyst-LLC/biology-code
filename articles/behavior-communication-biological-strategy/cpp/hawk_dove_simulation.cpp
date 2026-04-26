/*
 * Hawk-Dove conflict simulation in C++.
 *
 * This compact example calculates expected payoffs under different
 * resource values, conflict costs, and hawk frequencies.
 */

#include <iostream>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    double resource_value;
    double conflict_cost;
    double hawk_frequency;
};

int main() {
    std::vector<Scenario> scenarios = {
        {"low_cost_conflict", 10.0, 8.0, 0.50},
        {"balanced_conflict", 10.0, 20.0, 0.50},
        {"high_cost_conflict", 10.0, 40.0, 0.50},
        {"hawk_dominated", 10.0, 20.0, 0.80},
        {"dove_dominated", 10.0, 20.0, 0.20}
    };

    for (const auto& scenario : scenarios) {
        double dove_frequency = 1.0 - scenario.hawk_frequency;

        double hawk_against_hawk =
            (scenario.resource_value - scenario.conflict_cost) / 2.0;

        double hawk_against_dove = scenario.resource_value;
        double dove_against_hawk = 0.0;
        double dove_against_dove = scenario.resource_value / 2.0;

        double expected_hawk =
            scenario.hawk_frequency * hawk_against_hawk +
            dove_frequency * hawk_against_dove;

        double expected_dove =
            scenario.hawk_frequency * dove_against_hawk +
            dove_frequency * dove_against_dove;

        std::string advantaged =
            expected_hawk > expected_dove ? "hawk" : "dove";

        std::cout
            << "scenario=" << scenario.name
            << " expected_hawk=" << expected_hawk
            << " expected_dove=" << expected_dove
            << " advantaged_strategy=" << advantaged
            << std::endl;
    }

    return 0;
}
