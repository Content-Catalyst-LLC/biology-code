/*
 * Compact biological simulation and sequence summary kernel in C.
 */

#include <ctype.h>
#include <stdio.h>
#include <string.h>

double logistic_growth(double initial, double growth_rate, double carrying_capacity, double dt, int steps) {
    double population = initial;

    for (int step = 0; step <= steps; step++) {
        double growth = growth_rate * population * (1.0 - population / carrying_capacity);
        population = population + dt * growth;
        if (population < 0.0) population = 0.0;
    }

    return population;
}

double gc_content(const char *sequence) {
    double valid = 0.0;
    double gc = 0.0;

    for (size_t i = 0; i < strlen(sequence); i++) {
        char base = toupper(sequence[i]);

        if (base == 'A' || base == 'T') {
            valid += 1.0;
        } else if (base == 'G' || base == 'C') {
            valid += 1.0;
            gc += 1.0;
        }
    }

    if (valid == 0.0) return 0.0;
    return gc / valid;
}

int main(void) {
    const char *sequence = "ATGCGCGTAATTAACCGGTTACCGTAGCTA";

    printf("final_population=%.6f\n", logistic_growth(25.0, 0.35, 1000.0, 0.1, 200));
    printf("gc_content=%.6f\n", gc_content(sequence));

    return 0;
}
