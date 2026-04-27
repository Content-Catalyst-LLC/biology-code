/*
 * Compact probability and biological inference numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>

double binomial_log_likelihood(double successes, double trials, double p) {
    if (p <= 0.0 || p >= 1.0) return -INFINITY;
    double failures = trials - successes;
    return successes * log(p) + failures * log(1.0 - p);
}

int main(void) {
    double successes = 68.0;
    double trials = 100.0;
    double failures = trials - successes;

    double estimate = successes / trials;
    double se = sqrt(estimate * (1.0 - estimate) / trials);
    double ci_lower = fmax(estimate - 1.96 * se, 0.0);
    double ci_upper = fmin(estimate + 1.96 * se, 1.0);

    double alpha_prior = 1.0;
    double beta_prior = 1.0;
    double alpha_post = alpha_prior + successes;
    double beta_post = beta_prior + failures;
    double total = alpha_post + beta_post;
    double posterior_mean = alpha_post / total;
    double posterior_sd = sqrt((alpha_post * beta_post) / (total * total * (total + 1.0)));

    double best_p = 0.0;
    double best_ll = -INFINITY;

    for (int i = 10; i <= 90; i++) {
        double p = i / 100.0;
        double ll = binomial_log_likelihood(successes, trials, p);
        if (ll > best_ll) {
            best_ll = ll;
            best_p = p;
        }
    }

    printf("estimate=%.6f\n", estimate);
    printf("standard_error=%.6f\n", se);
    printf("ci_lower=%.6f\n", ci_lower);
    printf("ci_upper=%.6f\n", ci_upper);
    printf("posterior_mean=%.6f\n", posterior_mean);
    printf("posterior_sd=%.6f\n", posterior_sd);
    printf("best_likelihood_p=%.6f\n", best_p);
    printf("best_log_likelihood=%.6f\n", best_ll);

    return 0;
}
