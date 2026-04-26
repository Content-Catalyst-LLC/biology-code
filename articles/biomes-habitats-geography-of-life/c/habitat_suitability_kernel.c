/*
 * Compact habitat suitability kernel in C.
 *
 * This example calculates a simple suitability score from normalized
 * ecological predictors. It is not a full species distribution model.
 */

#include <stdio.h>

double habitat_suitability(
    double climate_match,
    double soil_quality,
    double connectivity,
    double disturbance,
    double land_use_pressure
) {
    return 0.30 * climate_match
         + 0.25 * soil_quality
         + 0.25 * connectivity
         - 0.10 * disturbance
         - 0.10 * land_use_pressure;
}

int main(void) {
    double score = habitat_suitability(
        0.85,
        0.72,
        0.80,
        0.20,
        0.25
    );

    printf("habitat_suitability=%.3f\n", score);

    return 0;
}
