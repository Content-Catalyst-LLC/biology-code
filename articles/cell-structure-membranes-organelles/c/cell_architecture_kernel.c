/*
 * Compact cell-architecture kernel in C.
 */

#include <math.h>
#include <stdio.h>

double sphere_surface_area(double radius) {
    return 4.0 * M_PI * radius * radius;
}

double sphere_volume(double radius) {
    return (4.0 / 3.0) * M_PI * radius * radius * radius;
}

double surface_area_to_volume(double radius) {
    return sphere_surface_area(radius) / sphere_volume(radius);
}

double permeability_flux(double permeability, double c_out, double c_in) {
    return permeability * (c_out - c_in);
}

double diffusive_flux(double diffusion_coefficient, double gradient) {
    return -diffusion_coefficient * gradient;
}

double organelle_fraction(double organelle_area, double cell_area) {
    return organelle_area / cell_area;
}

double organelle_density(double count, double cell_area) {
    return count / cell_area;
}

int main(void) {
    double radius = 5.0;

    printf("surface_area_um2=%.6f\n", sphere_surface_area(radius));
    printf("volume_um3=%.6f\n", sphere_volume(radius));
    printf("sa_to_volume=%.6f\n", surface_area_to_volume(radius));
    printf("permeability_flux=%.6f\n", permeability_flux(0.05, 10.0, 3.0));
    printf("diffusive_flux=%.6f\n", diffusive_flux(2.0, -0.8));
    printf("mitochondrial_fraction=%.6f\n", organelle_fraction(62.0, 420.0));
    printf("lysosome_density=%.6f\n", organelle_density(18.0, 420.0));

    return 0;
}
