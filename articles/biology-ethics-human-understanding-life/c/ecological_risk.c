#include <stdio.h>

// Compact ecological-risk kernel.

int main(void) {
    double exposure = 0.75;
    double harm_magnitude = 0.70;
    double uncertainty = 0.80;
    double reversibility = 0.20;

    double ecological_risk = exposure * harm_magnitude * uncertainty;
    double reversibility_adjusted_risk = ecological_risk * (1.0 - reversibility);

    printf("ecological_risk=%.6f\n", ecological_risk);
    printf("reversibility_adjusted_risk=%.6f\n", reversibility_adjusted_risk);

    return 0;
}
