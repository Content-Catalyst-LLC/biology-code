/*
 * Compact developmental growth and differentiation kernel in C.
 */

#include <math.h>
#include <stdio.h>

double exponential_growth(double N0, double r, double t) {
    return N0 * exp(r * t);
}

double doubling_time(double r) {
    return log(2.0) / r;
}

double logistic_step(double N, double r, double K, double dt) {
    double dN = r * N * (1.0 - N / K);
    return N + dN * dt;
}

double morphogen_concentration(double x) {
    return exp(-5.0 * x);
}

int main(void) {
    double N0 = 1.0e4;
    double N24 = 4.0e4;
    double r = log(N24 / N0) / 24.0;

    printf("growth_rate=%.6f\n", r);
    printf("doubling_time_h=%.6f\n", doubling_time(r));
    printf("N_at_24h=%.2f\n", exponential_growth(N0, r, 24.0));
    printf("logistic_next=%.2f\n", logistic_step(1.0e4, 0.07, 6.2e4, 1.0));
    printf("morphogen_at_0_2=%.6f\n", morphogen_concentration(0.2));
    printf("lineage_1_fraction=%.6f\n", 0.14 / (0.14 + 0.09));

    return 0;
}
