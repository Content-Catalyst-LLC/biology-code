/*
 * Compact decomposition and Q10 kernel in C.
 *
 * This example calculates environmentally modified fungal decomposition.
 */

#include <math.h>
#include <stdio.h>

double temp_multiplier(double temp, double tref, double q10) {
    return pow(q10, (temp - tref) / 10.0);
}

double moisture_multiplier(double moisture, double m_opt, double sigma) {
    return exp(-pow(moisture - m_opt, 2.0) / (2.0 * sigma * sigma));
}

double quality_multiplier(double lignin_n, double slope) {
    return exp(-slope * lignin_n);
}

int main(void) {
    const double M0 = 100.0;
    const double k0 = 0.07;
    const double temp = 18.0;
    const double moisture = 0.58;
    const double lignin_n = 14.0;
    const double guild_effect = 1.0;

    const double fT = temp_multiplier(temp, 10.0, 2.0);
    const double fW = moisture_multiplier(moisture, 0.6, 0.22);
    const double fQ = quality_multiplier(lignin_n, 0.03);

    const double k_eff = k0 * fT * fW * fQ * guild_effect;
    const double remaining_mass = M0 * exp(-k_eff * 24.0);
    const double half_life = log(2.0) / k_eff;

    printf("effective_k=%.5f\n", k_eff);
    printf("remaining_mass_t24=%.3f\n", remaining_mass);
    printf("half_life=%.3f\n", half_life);

    return 0;
}
