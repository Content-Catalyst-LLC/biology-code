/*
 * Scenario-based microscopy image-analysis implementation in C++.
 */

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct GaussianObject {
    std::string object_id;
    double cx;
    double cy;
    double sigma;
    double amplitude;
};

double gaussian_intensity(double x, double y, const GaussianObject& object) {
    double distance_squared = std::pow(x - object.cx, 2.0) + std::pow(y - object.cy, 2.0);
    return object.amplitude * std::exp(-distance_squared / (2.0 * std::pow(object.sigma, 2.0)));
}

int main() {
    std::vector<GaussianObject> objects = {
        {"cell_01", 18.0, 20.0, 4.0, 140.0},
        {"cell_02", 42.0, 25.0, 5.0, 170.0},
        {"cell_03", 30.0, 45.0, 4.5, 155.0}
    };

    double threshold = 65.0;
    int foreground_pixels = 0;
    double integrated_intensity = 0.0;

    for (int y = 0; y < 64; y++) {
        for (int x = 0; x < 64; x++) {
            double intensity = 18.0;

            for (const auto& object : objects) {
                intensity += gaussian_intensity(x, y, object);
            }

            if (intensity >= threshold) {
                foreground_pixels++;
                integrated_intensity += intensity;
            }
        }
    }

    std::cout << "foreground_pixels=" << foreground_pixels << std::endl;
    std::cout << "integrated_intensity=" << integrated_intensity << std::endl;

    return 0;
}
