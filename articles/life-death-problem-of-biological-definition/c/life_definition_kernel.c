/*
 * Compact life-definition numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>

double viability_decay(double time, double initial_count, double loss_rate) {
    return initial_count * exp(-loss_rate * time);
}

double survival_probability(double time, double hazard_rate) {
    return exp(-hazard_rate * time);
}

double dormancy_remaining(double time, double dormant_initial, double mortality_rate, double reactivation_rate) {
    return dormant_initial * exp(-(mortality_rate + reactivation_rate) * time);
}

double activated_pool(double time, double dormant_initial, double mortality_rate, double reactivation_rate) {
    double total_rate = mortality_rate + reactivation_rate;
    if (total_rate == 0.0) {
        return 0.0;
    }
    return reactivation_rate * dormant_initial * (1.0 - exp(-total_rate * time)) / total_rate;
}

double heuristic_score(
    double organization,
    double metabolism,
    double autonomy,
    double heredity,
    double responsiveness,
    double evolutionary_capacity
) {
    return 0.18 * organization
        + 0.18 * metabolism
        + 0.16 * autonomy
        + 0.18 * heredity
        + 0.12 * responsiveness
        + 0.18 * evolutionary_capacity;
}

int main(void) {
    double loss_rate = log(4.0) / 48.0;

    printf("viable_count_48h=%.6f\n", viability_decay(48.0, 1.0e6, loss_rate));
    printf("survival_probability_48h=%.6f\n", survival_probability(48.0, loss_rate));
    printf("half_life_h=%.6f\n", log(2.0) / loss_rate);
    printf("dormant_20=%.6f\n", dormancy_remaining(20.0, 1.0e6, 0.02, 0.05));
    printf("activated_20=%.6f\n", activated_pool(20.0, 1.0e6, 0.02, 0.05));
    printf("bacterium_score=%.6f\n", heuristic_score(0.95, 0.90, 0.88, 0.90, 0.85, 0.90));
    printf("virus_score=%.6f\n", heuristic_score(0.55, 0.05, 0.10, 0.82, 0.25, 0.88));

    return 0;
}
