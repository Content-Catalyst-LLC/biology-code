/*
 * Compact enzyme kinetic kernel in C.
 */

#include <math.h>
#include <stdio.h>

double michaelis_menten(double substrate, double vmax, double km) {
    return (vmax * substrate) / (km + substrate);
}

double competitive_inhibition(double substrate, double vmax, double km, double inhibitor, double ki) {
    return (vmax * substrate) / (km * (1.0 + inhibitor / ki) + substrate);
}

double noncompetitive_inhibition(double substrate, double vmax, double km, double inhibitor, double ki) {
    return (vmax / (1.0 + inhibitor / ki)) * substrate / (km + substrate);
}

double hill_response(double substrate, double vmax, double k, double n) {
    return vmax * pow(substrate, n) / (pow(k, n) + pow(substrate, n));
}

double catalytic_efficiency(double kcat, double km) {
    return kcat / km;
}

double feedback_velocity(double substrate, double product, double vmax, double km, double kf) {
    double base = michaelis_menten(substrate, vmax, km);
    return base / (1.0 + product / kf);
}

int main(void) {
    double substrate = 10.0;
    double vmax = 120.0;
    double km = 5.0;
    double inhibitor = 4.0;
    double ki = 2.0;
    double product = 8.0;
    double kf = 6.0;

    printf("michaelis_menten=%.6f\n", michaelis_menten(substrate, vmax, km));
    printf("competitive_inhibition=%.6f\n", competitive_inhibition(substrate, vmax, km, inhibitor, ki));
    printf("noncompetitive_inhibition=%.6f\n", noncompetitive_inhibition(substrate, vmax, km, inhibitor, ki));
    printf("hill_response=%.6f\n", hill_response(substrate, vmax, 6.0, 2.5));
    printf("catalytic_efficiency=%.6f\n", catalytic_efficiency(75.0, km));
    printf("feedback_velocity=%.6f\n", feedback_velocity(substrate, product, vmax, km, kf));

    return 0;
}
