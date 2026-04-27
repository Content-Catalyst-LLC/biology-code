/*
 * Compact differential-equation biology numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>

double logistic_final(double n0, double r, double k, double dt, double t_end) {
    int steps = (int)floor(t_end / dt) + 1;
    double n = n0;

    for (int i = 1; i < steps; i++) {
        double dn = r * n * (1.0 - n / k);
        n = fmax(n + dn * dt, 0.0);
    }

    return n;
}

double homeostasis_final(double x0, double set_point, double k, double dt, double t_end) {
    int steps = (int)floor(t_end / dt) + 1;
    double x = x0;

    for (int i = 1; i < steps; i++) {
        double dx = -k * (x - set_point);
        x += dx * dt;
    }

    return x;
}

double pk_final(double c0, double elimination_rate, double dt, double t_end) {
    int steps = (int)floor(t_end / dt) + 1;
    double c = c0;

    for (int i = 1; i < steps; i++) {
        double dc = -elimination_rate * c;
        c = fmax(c + dc * dt, 0.0);
    }

    return c;
}

int main(void) {
    printf("logistic_final=%.6f\n", logistic_final(100.0, 0.30, 2000.0, 0.05, 40.0));
    printf("homeostasis_final=%.6f\n", homeostasis_final(180.0, 100.0, 0.18, 0.05, 30.0));
    printf("pk_final=%.6f\n", pk_final(20.0, 0.12, 0.05, 48.0));
    return 0;
}
