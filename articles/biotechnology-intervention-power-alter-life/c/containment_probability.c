#include <math.h>
#include <stdio.h>

// Compact containment probability kernel.

int main(void) {
    double failures[] = {0.010, 0.020, 0.050, 0.015, 0.010, 0.012};
    int n = 6;
    double prob_no_failure = 1.0;

    for (int i = 0; i < n; i++) {
        prob_no_failure *= (1.0 - failures[i]);
    }

    double prob_any_failure = 1.0 - prob_no_failure;

    printf("containment_layers=%d\n", n);
    printf("estimated_probability_any_layer_failure=%.6f\n", prob_any_failure);

    return 0;
}
