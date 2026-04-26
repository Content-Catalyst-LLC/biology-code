/*
 * Compact benefit-cost and infection-pressure kernel in C.
 */

#include <stdio.h>

double net_effect(double stress) {
    double benefit = 0.8 - 0.3 * stress;
    double cost = 0.2 + 0.4 * stress;
    return benefit - cost;
}

int main(void) {
    double host = 0.4;
    double pathogen = 0.5;
    double feedback = 0.03;

    for (int i = 0; i <= 10; ++i) {
        double stress = i / 10.0;
        printf("stress=%.2f net_effect=%.3f\n", stress, net_effect(stress));
    }

    for (int step = 0; step <= 60; ++step) {
        double infection_pressure = pathogen > host ? pathogen - host : 0.0;

        if (step % 10 == 0) {
            printf(
                "step=%d host=%.4f pathogen=%.4f infection_pressure=%.4f\n",
                step,
                host,
                pathogen,
                infection_pressure
            );
        }

        host += feedback * infection_pressure;

        if (host < 0.0) {
            host = 0.0;
        }

        if (host > 1.0) {
            host = 1.0;
        }

        double escape_gain = host > pathogen ? host - pathogen : 0.0;
        pathogen += feedback * escape_gain;

        if (pathogen < 0.0) {
            pathogen = 0.0;
        }

        if (pathogen > 1.0) {
            pathogen = 1.0;
        }
    }

    return 0;
}
