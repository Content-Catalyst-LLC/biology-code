/*
 * Compact animal allometry and survival kernel in C.
 */

#include <math.h>
#include <stdio.h>

int main(void) {
    const double B0 = 4.2;
    const double mass_kg = 80.0;

    const double metabolic_rate = B0 * pow(mass_kg, 0.75);
    const double mass_specific_rate = metabolic_rate / mass_kg;

    const double hazard = 0.012;
    const double survival_day_100 = exp(-hazard * 100.0);

    printf("metabolic_rate=%.4f\n", metabolic_rate);
    printf("mass_specific_rate=%.4f\n", mass_specific_rate);
    printf("survival_day_100=%.4f\n", survival_day_100);

    return 0;
}
