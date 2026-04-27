/*
 * Compact systems biology kernel in C.
 */

#include <math.h>
#include <stdio.h>

void simulate_feedback(
    double x0,
    double y0,
    double production_x,
    double production_y,
    double degradation_x,
    double degradation_y,
    double hill_n,
    double dt,
    int steps,
    double *final_x,
    double *final_y
) {
    double x = x0;
    double y = y0;

    for (int step = 0; step < steps; step++) {
        double dx = production_x / (1.0 + pow(y, hill_n)) - degradation_x * x;
        double dy = production_y * x - degradation_y * y;

        x = x + dt * dx;
        y = y + dt * dy;

        if (x < 0.0) x = 0.0;
        if (y < 0.0) y = 0.0;
    }

    *final_x = x;
    *final_y = y;
}

int main(void) {
    double x;
    double y;

    simulate_feedback(0.20, 0.10, 1.20, 0.80, 0.40, 0.30, 2.0, 0.10, 80, &x, &y);

    printf("final_x=%.6f\n", x);
    printf("final_y=%.6f\n", y);

    return 0;
}
