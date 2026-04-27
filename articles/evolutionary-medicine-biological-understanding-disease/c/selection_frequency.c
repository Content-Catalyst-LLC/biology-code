#include <stdio.h>

// Compact resistant-frequency selection kernel.

int main(void) {
    double frequency = 0.02;
    double selection_advantage = 0.18;
    double fitness_cost = 0.04;
    int steps = 20;

    for (int step = 0; step < steps; step++) {
        frequency = frequency * (1.0 + selection_advantage - fitness_cost);
        if (frequency > 1.0) frequency = 1.0;
        if (frequency < 0.0) frequency = 0.0;
    }

    printf("final_resistant_frequency=%.6f\n", frequency);
    return 0;
}
