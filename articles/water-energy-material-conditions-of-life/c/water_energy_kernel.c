/*
 * Compact water-energy biology kernel in C.
 */

#include <math.h>
#include <stdio.h>

const double R_GAS = 0.082057;

double osmotic_pressure(double i, double c, double t) {
    return i * c * R_GAS * t;
}

double water_potential(double solute, double pressure, double gravitational, double matric) {
    return solute + pressure + gravitational + matric;
}

double homeostatic_state(double time, double initial_value, double setpoint, double k) {
    return setpoint + (initial_value - setpoint) * exp(-k * time);
}

double exponential_growth(double time, double n0, double r) {
    return n0 * exp(r * time);
}

double monod_rate(double substrate, double mu_max, double ks) {
    return mu_max * substrate / (ks + substrate);
}

double oxygen_limited_rate(double oxygen, double half_saturation, double max_rate) {
    return max_rate * oxygen / (half_saturation + oxygen);
}

int main(void) {
    double r = log(4.0) / 48.0;

    printf("osmotic_pressure_atm=%.6f\n", osmotic_pressure(1.0, 0.30, 298.0));
    printf("water_potential_MPa=%.6f\n", water_potential(-0.60, 0.45, 0.01, -0.02));
    printf("homeostatic_state_t5=%.6f\n", homeostatic_state(5.0, 10.0, 2.0, 0.4));
    printf("exponential_growth_48h=%.6f\n", exponential_growth(48.0, 1.0e5, r));
    printf("doubling_time_h=%.6f\n", log(2.0) / r);
    printf("monod_rate=%.6f\n", monod_rate(4.0, 0.08, 2.5));
    printf("oxygen_limited_rate=%.6f\n", oxygen_limited_rate(4.0, 2.0, 1.0));

    return 0;
}
