#include <stdio.h>

// Compact reproducibility completeness kernel.

int main(void) {
    int required_steps = 6;
    int documented_steps = 6;
    int failed_cells = 0;
    int executed_cells = 4;

    double completeness = (double) documented_steps / (double) required_steps;
    double failure_rate = (double) failed_cells / (double) executed_cells;

    printf("workflow_completeness=%.5f\n", completeness);
    printf("failure_rate=%.5f\n", failure_rate);

    if (completeness == 1.0 && failure_rate == 0.0) {
        printf("status=pass\n");
    } else {
        printf("status=review\n");
    }

    return 0;
}
