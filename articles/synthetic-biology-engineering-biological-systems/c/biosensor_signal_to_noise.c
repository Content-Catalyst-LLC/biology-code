#include <math.h>
#include <stdio.h>

// Compact biosensor signal-to-noise kernel.

double signal_to_noise(double mean_signal, double mean_background, double background_sd) {
    return (mean_signal - mean_background) / background_sd;
}

int main(void) {
    double mean_signal[] = {1250.0, 980.0, 1430.0};
    double mean_background[] = {220.0, 210.0, 410.0};
    double background_sd[] = {65.0, 80.0, 120.0};
    int n = 3;

    for (int i = 0; i < n; i++) {
        printf("design=%d signal_to_noise=%.5f\n",
               i + 1,
               signal_to_noise(mean_signal[i], mean_background[i], background_sd[i]));
    }

    return 0;
}
