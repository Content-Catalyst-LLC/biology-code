/*
 * Compact host-pathogen-immune threshold kernel in C.
 *
 * This example simulates pathogen load, immune activity, and damage burden
 * and classifies the result using illustrative thresholds.
 */

#include <stdio.h>

int main(void) {
    const double dt = 0.05;
    const int n_steps = 601;

    const double r = 0.45;
    const double c = 0.12;
    const double alpha = 0.08;
    const double delta = 0.18;
    const double gamma = 0.06;
    const double rho = 0.10;

    double pathogen = 50.0;
    double immune = 2.0;
    double damage = 0.0;

    double peak_pathogen = pathogen;
    double peak_immune = immune;
    double peak_damage = damage;

    for (int step = 1; step < n_steps; step++) {
        double d_pathogen = r * pathogen - c * immune * pathogen;
        double d_immune = alpha * pathogen - delta * immune;
        double d_damage = gamma * immune - rho * damage;

        pathogen += d_pathogen * dt;
        immune += d_immune * dt;
        damage += d_damage * dt;

        if (pathogen < 0.0) pathogen = 0.0;
        if (immune < 0.0) immune = 0.0;
        if (damage < 0.0) damage = 0.0;

        if (pathogen > peak_pathogen) peak_pathogen = pathogen;
        if (immune > peak_immune) peak_immune = immune;
        if (damage > peak_damage) peak_damage = damage;
    }

    const char *risk_class = "controlled";

    if (peak_pathogen > 200.0 || peak_damage > 20.0) {
        risk_class = "high-risk";
    } else if (peak_pathogen > 100.0 || peak_damage > 10.0) {
        risk_class = "stressed";
    }

    printf("peak_pathogen=%.3f\n", peak_pathogen);
    printf("peak_immune=%.3f\n", peak_immune);
    printf("peak_damage=%.3f\n", peak_damage);
    printf("final_pathogen=%.3f\n", pathogen);
    printf("final_damage=%.3f\n", damage);
    printf("risk_class=%s\n", risk_class);

    return 0;
}
