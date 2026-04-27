/*
 * Compact nonlinear feedback numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>

double saturating_response(double signal, double vmax, double k_half) {
    return vmax * signal / (k_half + signal);
}

double hill_response(double signal, double k_half, double n) {
    return pow(signal, n) / (pow(k_half, n) + pow(signal, n));
}

double negative_feedback_final(double x0, double set_point, double k, double dt, double t_end) {
    int steps = (int)floor(t_end / dt) + 1;
    double x = x0;

    for (int i = 1; i < steps; i++) {
        double dx = -k * (x - set_point);
        x += dx * dt;
    }

    return x;
}

double positive_feedback_final(double x0, double alpha, double beta, double k_half, double n, double dt, double t_end) {
    int steps = (int)floor(t_end / dt) + 1;
    double x = x0;

    for (int i = 1; i < steps; i++) {
        double production = alpha * pow(x, n) / (pow(k_half, n) + pow(x, n));
        double loss = beta * x;
        double dx = production - loss;
        x = fmax(x + dx * dt, 0.0);
    }

    return x;
}

int main(void) {
    printf("saturating_at_20=%.6f\n", saturating_response(20.0, 1.0, 20.0));
    printf("hill_at_60_n4=%.6f\n", hill_response(60.0, 40.0, 4.0));
    printf("negative_feedback_final=%.6f\n", negative_feedback_final(180.0, 100.0, 0.18, 0.05, 30.0));
    printf("positive_feedback_final=%.6f\n", positive_feedback_final(2.0, 3.0, 0.8, 1.5, 4.0, 0.01, 80.0));
    return 0;
}
