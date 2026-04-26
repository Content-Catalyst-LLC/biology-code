/*
 * Compact balance and feedback kernel in C.
 *
 * This example simulates a regulated variable, hormonal signal, and effector
 * response under coupled feedback dynamics.
 */

#include <math.h>
#include <stdio.h>

int main(void) {
    const double dt = 0.05;
    const int n_steps = 801;

    const double x_star = 5.0;
    const double input_rate = 0.6;
    const double a = 0.9;
    const double b = 0.5;
    const double c = 0.7;
    const double d = 0.4;
    const double u0 = 0.3;
    const double u1 = 0.25;

    double regulated = 10.0;
    double hormone = 0.0;
    double effector = 0.0;

    double peak_regulated = regulated;
    double peak_hormone = hormone;
    double peak_effector = effector;

    for (int step = 1; step < n_steps; step++) {
        double uptake = u0 + u1 * hormone * regulated;

        double d_regulated = input_rate - uptake;
        double d_hormone = a * (regulated - x_star) - b * hormone;
        double d_effector = c * hormone - d * effector;

        regulated += d_regulated * dt;
        hormone += d_hormone * dt;
        effector += d_effector * dt;

        if (regulated < 0.0) regulated = 0.0;
        if (hormone < 0.0) hormone = 0.0;
        if (effector < 0.0) effector = 0.0;

        if (regulated > peak_regulated) peak_regulated = regulated;
        if (hormone > peak_hormone) peak_hormone = hormone;
        if (effector > peak_effector) peak_effector = effector;
    }

    printf("peak_regulated=%.3f\n", peak_regulated);
    printf("peak_hormone=%.3f\n", peak_hormone);
    printf("peak_effector=%.3f\n", peak_effector);
    printf("final_regulated=%.3f\n", regulated);
    printf("recovery_error=%.3f\n", fabs(regulated - x_star));

    return 0;
}
