#include <stdio.h>

// Compact nutrient-use efficiency kernel.

int main(void) {
    double nutrient_input_kg[] = {12000.0, 7600.0, 5200.0};
    double nutrient_harvested_kg[] = {4800.0, 4100.0, 3600.0};
    int n = 3;

    for (int i = 0; i < n; i++) {
        double nue = nutrient_harvested_kg[i] / nutrient_input_kg[i];
        printf("system=%d nutrient_use_efficiency=%.6f\n", i + 1, nue);
    }

    return 0;
}
