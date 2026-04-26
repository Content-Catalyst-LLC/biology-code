/*
 * Compact carbon-balance kernel in C.
 *
 * net atmospheric increment =
 *   anthropogenic emissions + disturbance release - land uptake - ocean uptake
 */

#include <stdio.h>

double net_atmospheric_increment(
    double anthropogenic_emissions,
    double disturbance_release,
    double land_uptake,
    double ocean_uptake
) {
    return anthropogenic_emissions + disturbance_release - land_uptake - ocean_uptake;
}

int main(void) {
    double emissions = 11.0;
    double disturbance = 0.8;
    double land_uptake = 3.2;
    double ocean_uptake = 2.7;

    double net_increment = net_atmospheric_increment(
        emissions,
        disturbance,
        land_uptake,
        ocean_uptake
    );

    printf("net_atmospheric_increment=%.3f\n", net_increment);

    return 0;
}
