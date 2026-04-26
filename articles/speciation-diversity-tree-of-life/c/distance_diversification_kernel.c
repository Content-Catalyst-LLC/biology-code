/*
 * Compact sequence-distance and diversification kernel in C.
 */

#include <math.h>
#include <stdio.h>

double jukes_cantor(double p_distance) {
    if (p_distance >= 0.75) {
        return NAN;
    }

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * p_distance);
}

double fst_style(double p1, double p2) {
    double h1 = 2.0 * p1 * (1.0 - p1);
    double h2 = 2.0 * p2 * (1.0 - p2);
    double pbar = (p1 + p2) / 2.0;
    double ht = 2.0 * pbar * (1.0 - pbar);
    double hs = (h1 + h2) / 2.0;

    if (ht <= 0.0) {
        return 0.0;
    }

    return (ht - hs) / ht;
}

int main(void) {
    double p1 = 0.70;
    double p2 = 0.42;
    double p_distance = 0.15;
    double lambda = 0.10;
    double mu = 0.03;

    printf("delta_p=%.4f\n", fabs(p1 - p2));
    printf("fst_style=%.4f\n", fst_style(p1, p2));
    printf("jukes_cantor=%.4f\n", jukes_cantor(p_distance));
    printf("net_diversification=%.4f\n", lambda - mu);

    return 0;
}
