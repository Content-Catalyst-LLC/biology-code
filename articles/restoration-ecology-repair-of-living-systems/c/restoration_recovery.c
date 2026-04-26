/*
Restoration Recovery Model in C

Simple recovery model:

dR/dt = k(T - R)
*/

#include <stdio.h>

int main(void) {
    double R = 40.0;
    double target = 80.0;
    double k = 0.1;
    double dt = 0.5;
    int n_steps = 100;

    printf("step,time,recovery_state\n");

    for (int step = 0; step <= n_steps; step++) {
        double time = step * dt;
        printf("%d,%.4f,%.8f\n", step, time, R);
        R = R + k * (target - R) * dt;
    }

    return 0;
}
