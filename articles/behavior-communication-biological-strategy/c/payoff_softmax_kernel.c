/*
 * Compact payoff and softmax kernel in C.
 *
 * This example calculates utilities and softmax choice probabilities for
 * behavioral options.
 */

#include <math.h>
#include <stdio.h>

int main(void) {
    const int n = 4;

    double benefit[] = {8.0, 14.0, 10.0, 12.0};
    double energetic_cost[] = {2.0, 5.0, 4.0, 6.0};
    double predation_risk[] = {1.0, 6.0, 3.0, 5.0};
    double utility[4];
    double exp_values[4];

    double beta = 1.1;
    double max_utility = -1e9;
    double denominator = 0.0;

    for (int i = 0; i < n; i++) {
        utility[i] = benefit[i] - 0.8 * energetic_cost[i] - 1.2 * predation_risk[i];

        if (utility[i] > max_utility) {
            max_utility = utility[i];
        }
    }

    for (int i = 0; i < n; i++) {
        exp_values[i] = exp(beta * (utility[i] - max_utility));
        denominator += exp_values[i];
    }

    for (int i = 0; i < n; i++) {
        printf(
            "option=%d utility=%.3f probability=%.3f\n",
            i + 1,
            utility[i],
            exp_values[i] / denominator
        );
    }

    return 0;
}
