/*
 * Compact mathematical-biology numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>

double logistic_growth(double t, double n0, double r, double k) {
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t));
}

double michaelis_menten(double substrate, double vmax, double km) {
    return vmax * substrate / (km + substrate);
}

int main(void) {
    double logistic_final = logistic_growth(40.0, 100.0, 0.30, 2000.0);
    double enzyme_velocity = michaelis_menten(5.0, 10.0, 2.0);

    double beta = 0.35;
    double gamma = 0.10;
    double dt = 0.05;
    int steps = (int)(120.0 / dt);

    double s = 0.99;
    double i = 0.01;
    double r = 0.0;
    double peak_i = i;
    double time_to_peak = 0.0;

    for (int step = 0; step < steps; step++) {
        double time = step * dt;

        if (i > peak_i) {
            peak_i = i;
            time_to_peak = time;
        }

        double ds = -beta * s * i;
        double di = beta * s * i - gamma * i;
        double dr = gamma * i;

        s = fmax(s + ds * dt, 0.0);
        i = fmax(i + di * dt, 0.0);
        r = fmax(r + dr * dt, 0.0);
    }

    printf("logistic_final=%.6f\n", logistic_final);
    printf("michaelis_menten_velocity=%.6f\n", enzyme_velocity);
    printf("sir_peak_infected=%.6f\n", peak_i);
    printf("sir_time_to_peak=%.6f\n", time_to_peak);
    printf("sir_final_recovered=%.6f\n", r);

    return 0;
}
