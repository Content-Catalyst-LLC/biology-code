/*
 * Compact biomolecular kernel in C.
 */

#include <math.h>
#include <stdio.h>
#include <string.h>

double michaelis_menten(double substrate, double vmax, double km) {
    return (vmax * substrate) / (km + substrate);
}

double ligand_fraction_bound(double ligand, double kd) {
    return ligand / (kd + ligand);
}

double diffusive_flux(double diffusion_coefficient, double concentration_gradient) {
    return -diffusion_coefficient * concentration_gradient;
}

double polymer_mass_estimate(int monomer_count, double mean_monomer_mass, double water_loss_per_bond) {
    int bonds = monomer_count > 0 ? monomer_count - 1 : 0;
    return monomer_count * mean_monomer_mass - bonds * water_loss_per_bond;
}

double gc_content(const char *sequence) {
    int g = 0;
    int c = 0;
    int total = 0;

    for (size_t i = 0; i < strlen(sequence); i++) {
        if (sequence[i] == 'G') g++;
        if (sequence[i] == 'C') c++;
        if (sequence[i] == 'A' || sequence[i] == 'T' || sequence[i] == 'G' || sequence[i] == 'C') total++;
    }

    if (total == 0) {
        return NAN;
    }

    return (double)(g + c) / (double)total;
}

int main(void) {
    printf("velocity=%.6f\n", michaelis_menten(6.0, 100.0, 3.0));
    printf("fraction_bound=%.6f\n", ligand_fraction_bound(8.0, 8.0));
    printf("diffusive_flux=%.6f\n", diffusive_flux(2.0, -0.8));
    printf("polymer_mass=%.6f\n", polymer_mass_estimate(12, 110.0, 18.015));
    printf("gc_content=%.6f\n", gc_content("ATGCGCGTATTAACCGGTTAGCGCGATATCGCGTA"));

    return 0;
}
