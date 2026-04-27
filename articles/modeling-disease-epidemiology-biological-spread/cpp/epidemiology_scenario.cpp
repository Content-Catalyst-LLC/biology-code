/*
 * Scenario-based epidemiology implementation in C++.
 */

#include <algorithm>
#include <iostream>
#include <string>
#include <tuple>
#include <vector>

struct Scenario {
    std::string name;
    double population;
    double initial_infected;
    double beta;
    double gamma;
    double dt;
    int steps;
};

std::tuple<double, double, double> sir_final(const Scenario& scenario) {
    double susceptible = scenario.population - scenario.initial_infected;
    double infected = scenario.initial_infected;
    double recovered = 0.0;

    for (int step = 0; step < scenario.steps; step++) {
        double new_infections = scenario.beta * susceptible * infected / scenario.population;
        double new_recoveries = scenario.gamma * infected;

        susceptible = std::max(susceptible - scenario.dt * new_infections, 0.0);
        infected = std::max(infected + scenario.dt * (new_infections - new_recoveries), 0.0);
        recovered = std::min(recovered + scenario.dt * new_recoveries, scenario.population);
    }

    return {susceptible, infected, recovered};
}

int main() {
    std::vector<Scenario> scenarios = {
        {"baseline", 10000.0, 10.0, 0.32, 0.10, 0.25, 240},
        {"reduced_transmission", 10000.0, 10.0, 0.22, 0.10, 0.25, 240},
        {"faster_recovery", 10000.0, 10.0, 0.32, 0.16, 0.25, 240}
    };

    for (const auto& scenario : scenarios) {
        auto [s, i, r] = sir_final(scenario);

        std::cout
            << "scenario=" << scenario.name
            << " final_susceptible=" << s
            << " final_infected=" << i
            << " final_recovered=" << r
            << std::endl;
    }

    return 0;
}
