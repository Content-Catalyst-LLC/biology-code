/*
 * Compact cell-theory numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>

double exponential_growth(double time, double initial_count, double growth_rate) {
    return initial_count * exp(growth_rate * time);
}

double logistic_growth(double time, double initial_count, double growth_rate, double carrying_capacity) {
    return carrying_capacity / (1.0 + ((carrying_capacity - initial_count) / initial_count) * exp(-growth_rate * time));
}

double viability_decay(double time, double initial_count, double loss_rate) {
    return initial_count * exp(-loss_rate * time);
}

double membrane_flux(double diffusion_coefficient, double concentration_inside, double concentration_outside, double distance) {
    double gradient = (concentration_outside - concentration_inside) / distance;
    return -diffusion_coefficient * gradient;
}

double cell_condition_score(
    double membrane,
    double metabolism,
    double proliferation,
    double genome,
    double organelle,
    double stress
) {
    return 0.18 * membrane
        + 0.22 * metabolism
        + 0.18 * proliferation
        + 0.17 * genome
        + 0.15 * organelle
        + 0.10 * (1.0 - stress);
}

int main(void) {
    double growth_rate = log(4.0) / 48.0;
    double loss_rate = log(1000000.0 / 320000.0) / 48.0;

    printf("growth_rate=%.6f\n", growth_rate);
    printf("doubling_time_h=%.6f\n", log(2.0) / growth_rate);
    printf("exponential_growth_48h=%.6f\n", exponential_growth(48.0, 1.0e5, growth_rate));
    printf("logistic_growth_96h=%.6f\n", logistic_growth(96.0, 1.0e5, 0.035, 1.0e6));
    printf("viability_48h=%.6f\n", viability_decay(48.0, 1.0e6, loss_rate));
    printf("membrane_flux=%.8f\n", membrane_flux(2.0e-6, 1.0, 0.2, 0.01));
    printf("cell_condition_score=%.6f\n", cell_condition_score(0.92, 0.88, 0.84, 0.90, 0.86, 0.12));

    return 0;
}
