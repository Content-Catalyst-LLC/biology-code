/*
 * Compact computational ecology kernel in C.
 */

#include <math.h>
#include <stdio.h>

double logistic(double x) {
    return 1.0 / (1.0 + exp(-x));
}

double habitat_suitability(double temperature_c, double precipitation_mm, double habitat_quality, double disturbance) {
    double score = -2.0
        + 0.05 * temperature_c
        + 0.0015 * precipitation_mm
        + 2.4 * habitat_quality
        - 2.0 * disturbance;

    return logistic(score);
}

double patch_occupancy(double initial_occupancy, double colonization, double extinction, int steps) {
    double occupancy = initial_occupancy;

    for (int step = 0; step < steps; step++) {
        occupancy = occupancy * (1.0 - extinction) + (1.0 - occupancy) * colonization;
        if (occupancy < 0.0) occupancy = 0.0;
        if (occupancy > 1.0) occupancy = 1.0;
    }

    return occupancy;
}

double runoff(double precipitation_mm, double infiltration_fraction, double runoff_coefficient) {
    return precipitation_mm * (1.0 - infiltration_fraction) * runoff_coefficient;
}

int main(void) {
    printf("suitability=%.6f\n", habitat_suitability(16.2, 820.0, 0.82, 0.18));
    printf("final_occupancy=%.6f\n", patch_occupancy(0.42, 0.12, 0.08, 30));
    printf("runoff_mm=%.6f\n", runoff(42.0, 0.62, 0.30));

    return 0;
}
