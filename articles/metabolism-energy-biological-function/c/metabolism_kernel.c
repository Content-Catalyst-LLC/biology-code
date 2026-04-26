/*
 * Compact metabolism kernel in C.
 */

#include <math.h>
#include <stdio.h>

double exponential_growth(double t, double n0, double r) {
    return n0 * exp(r * t);
}

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t));
}

double doubling_time(double r) {
    if (r <= 0.0) {
        return NAN;
    }
    return log(2.0) / r;
}

double monod_growth(double substrate, double mu_max, double ks) {
    return mu_max * substrate / (ks + substrate);
}

double biomass_yield(double delta_x, double delta_s) {
    return delta_x / delta_s;
}

double toy_objective(double biomass_flux, double product_flux) {
    return biomass_flux + 0.25 * product_flux;
}

int main(void) {
    double n0 = 1.0e5;
    double r = log(4.0) / 48.0;

    printf("abundance_48h=%.6f\n", exponential_growth(48.0, n0, r));
    printf("doubling_time_h=%.6f\n", doubling_time(r));
    printf("logistic_96h=%.6f\n", logistic_growth(96.0, n0, 0.035, 1.0e6));
    printf("monod_growth=%.6f\n", monod_growth(5.0, 0.08, 2.5));
    printf("biomass_yield=%.6f\n", biomass_yield(0.75, 1.50));
    printf("maintenance_fraction=%.6f\n", 0.70 / 2.0);
    printf("toy_objective=%.6f\n", toy_objective(8.0, 2.0));

    return 0;
}
