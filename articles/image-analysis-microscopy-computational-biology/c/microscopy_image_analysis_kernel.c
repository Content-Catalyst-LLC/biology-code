/*
 * Compact microscopy image-analysis kernel in C.
 */

#include <math.h>
#include <stdio.h>

double gaussian_intensity(double x, double y, double cx, double cy, double sigma, double amplitude) {
    double distance_squared = pow(x - cx, 2.0) + pow(y - cy, 2.0);
    return amplitude * exp(-distance_squared / (2.0 * pow(sigma, 2.0)));
}

double synthetic_intensity(double x, double y) {
    return 18.0
        + gaussian_intensity(x, y, 18.0, 20.0, 4.0, 140.0)
        + gaussian_intensity(x, y, 42.0, 25.0, 5.0, 170.0)
        + gaussian_intensity(x, y, 30.0, 45.0, 4.5, 155.0);
}

int main(void) {
    double threshold = 65.0;
    int foreground_pixels = 0;
    double integrated_intensity = 0.0;

    for (int y = 0; y < 64; y++) {
        for (int x = 0; x < 64; x++) {
            double intensity = synthetic_intensity((double)x, (double)y);

            if (intensity >= threshold) {
                foreground_pixels++;
                integrated_intensity += intensity;
            }
        }
    }

    printf("foreground_pixels=%d\n", foreground_pixels);
    printf("integrated_intensity=%.6f\n", integrated_intensity);

    return 0;
}
