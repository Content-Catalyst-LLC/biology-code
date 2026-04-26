/*
Restoration Parameter Sweep in C++
*/

#include <algorithm>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

struct Scenario {
    std::string name;
    double S;
    double B;
    double D;
};

struct Result {
    double finalV;
    double finalM;
    double finalF;
    double peakF;
};

Result simulate(double S, double B, double D) {
    const double a = 0.8;
    const double b = 0.15;
    const double c = 0.20;
    const double p = 0.10;
    const double q = 0.25;
    const double r = 0.12;
    const double u = 0.08;
    const double v = 0.10;
    const double w = 0.18;
    const double dt = 0.05;
    const double tEnd = 50.0;

    double V = 10.0;
    double M = 8.0;
    double F = 6.0;
    double peakF = F;

    for (double time = dt; time <= tEnd + 1e-12; time += dt) {
        double dV = a * S - b * V - c * D;
        double dM = p * V + q * B - r * M;
        double dF = u * V + v * M - w * D;

        V = std::max(0.0, V + dV * dt);
        M = std::max(0.0, M + dM * dt);
        F = std::max(0.0, F + dF * dt);

        peakF = std::max(peakF, F);
    }

    return {V, M, F, peakF};
}

int main() {
    std::vector<Scenario> scenarios = {
        {"low_effort_high_disturbance", 0.7, 0.8, 0.8},
        {"moderate_effort_moderate_disturbance", 1.0, 0.8, 0.5},
        {"high_effort_low_disturbance", 1.4, 0.8, 0.2},
        {"soil_limited_recovery", 1.1, 0.3, 0.4}
    };

    std::cout << "scenario,final_V,final_M,final_F,peak_F\n";

    for (const auto& scenario : scenarios) {
        Result result = simulate(scenario.S, scenario.B, scenario.D);

        std::cout << scenario.name << ","
                  << std::setprecision(8)
                  << result.finalV << ","
                  << result.finalM << ","
                  << result.finalF << ","
                  << result.peakF << "\n";
    }

    return 0;
}
