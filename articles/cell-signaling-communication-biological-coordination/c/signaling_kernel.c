/*
 * Compact signaling kernel in C.
 */

#include <math.h>
#include <stdio.h>

double receptor_occupancy(double L, double Kd) {
    return L / (Kd + L);
}

double hill_response(double L, double K, double n) {
    return pow(L, n) / (pow(K, n) + pow(L, n));
}

double messenger_decay(double M0, double k, double t) {
    return M0 * exp(-k * t);
}

double signaling_half_life(double k) {
    return log(2.0) / k;
}

double quorum_update(double Q, double N, double a, double d, double dt) {
    double next = Q + (a * N - d * Q) * dt;
    if (next < 0.0) {
        return 0.0;
    }
    return next;
}

int main(void) {
    double L = 3.0;
    double Kd = 1.5;
    double K = 2.0;
    double n = 3.0;
    double k = log(4.0) / 4.0;

    printf("occupancy=%.6f\n", receptor_occupancy(L, Kd));
    printf("hill_response=%.6f\n", hill_response(L, K, n));
    printf("signal_at_4_min=%.6f\n", messenger_decay(100.0, k, 4.0));
    printf("half_life_min=%.6f\n", signaling_half_life(k));
    printf("quorum_next=%.6f\n", quorum_update(0.5, 1e8, 1e-9, 0.35, 0.1));

    return 0;
}
