/*
 * Compact biological modeling kernel in C.
 */

#include <stdio.h>

double logistic_growth(double initial, double growth_rate, double carrying_capacity, double dt, int steps) {
    double population = initial;

    for (int step = 0; step < steps; step++) {
        double growth = growth_rate * population * (1.0 - population / carrying_capacity);
        population = population + dt * growth;
        if (population < 0.0) population = 0.0;
    }

    return population;
}

void two_compartment(
    double initial_a,
    double initial_b,
    double k_ab,
    double k_ba,
    double k_clear,
    double dt,
    int steps,
    double *final_a,
    double *final_b
) {
    double amount_a = initial_a;
    double amount_b = initial_b;

    for (int step = 0; step < steps; step++) {
        double flow_ab = k_ab * amount_a;
        double flow_ba = k_ba * amount_b;
        double clearance = k_clear * amount_a;

        double next_a = amount_a + dt * (-flow_ab + flow_ba - clearance);
        double next_b = amount_b + dt * (flow_ab - flow_ba);

        if (next_a < 0.0) next_a = 0.0;
        if (next_b < 0.0) next_b = 0.0;

        amount_a = next_a;
        amount_b = next_b;
    }

    *final_a = amount_a;
    *final_b = amount_b;
}

int main(void) {
    double final_population = logistic_growth(25.0, 0.35, 1000.0, 0.1, 200);
    double final_a;
    double final_b;

    two_compartment(100.0, 0.0, 0.18, 0.07, 0.03, 0.1, 150, &final_a, &final_b);

    printf("final_population=%.6f\n", final_population);
    printf("final_compartment_a=%.6f\n", final_a);
    printf("final_compartment_b=%.6f\n", final_b);
    printf("final_total_amount=%.6f\n", final_a + final_b);

    return 0;
}
