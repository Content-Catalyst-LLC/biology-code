/*
 * Compact epidemiology modeling kernel in C.
 */

#include <stdio.h>

void sir_final(
    double population,
    double initial_infected,
    double beta,
    double gamma,
    double dt,
    int steps,
    double *susceptible_out,
    double *infected_out,
    double *recovered_out
) {
    double susceptible = population - initial_infected;
    double infected = initial_infected;
    double recovered = 0.0;

    for (int step = 0; step < steps; step++) {
        double new_infections = beta * susceptible * infected / population;
        double new_recoveries = gamma * infected;

        susceptible = susceptible - dt * new_infections;
        infected = infected + dt * (new_infections - new_recoveries);
        recovered = recovered + dt * new_recoveries;

        if (susceptible < 0.0) susceptible = 0.0;
        if (infected < 0.0) infected = 0.0;
        if (recovered > population) recovered = population;
    }

    *susceptible_out = susceptible;
    *infected_out = infected;
    *recovered_out = recovered;
}

int main(void) {
    double s;
    double i;
    double r;

    sir_final(10000.0, 10.0, 0.32, 0.10, 0.25, 240, &s, &i, &r);

    printf("sir_final_susceptible=%.6f\n", s);
    printf("sir_final_infected=%.6f\n", i);
    printf("sir_final_recovered=%.6f\n", r);

    return 0;
}
