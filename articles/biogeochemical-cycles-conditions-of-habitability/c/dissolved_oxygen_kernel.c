/*
 * Compact dissolved-oxygen balance kernel in C.
 *
 * oxygen_change = production - respiration - decomposition - stratification
 */

#include <stdio.h>

double oxygen_change(
    double oxygen_production,
    double respiration_demand,
    double decomposition_demand,
    double stratification_limitation
) {
    return oxygen_production
         - respiration_demand
         - decomposition_demand
         - stratification_limitation;
}

int main(void) {
    double change = oxygen_change(6.2, 2.1, 1.3, 0.6);
    double baseline_oxygen = 8.0;
    double projected_oxygen = baseline_oxygen + change;

    printf("oxygen_change=%.3f\n", change);
    printf("projected_oxygen=%.3f\n", projected_oxygen);

    return 0;
}
