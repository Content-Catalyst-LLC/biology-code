/*
 * Habitat fragmentation index example in C.
 *
 * The index below is intentionally simple:
 * fragmentation = patch_count / total_habitat_area
 *
 * Higher values indicate that remaining habitat is split into many small
 * patches relative to total habitat area.
 */

#include <stdio.h>

double fragmentation_index(double patch_areas[], int patch_count) {
    double total_area = 0.0;

    for (int i = 0; i < patch_count; i++) {
        total_area += patch_areas[i];
    }

    if (total_area <= 0.0) {
        return 0.0;
    }

    return (double)patch_count / total_area;
}

int main(void) {
    double patch_areas[] = {120.0, 35.0, 210.0, 18.0, 76.0, 44.0};
    int patch_count = sizeof(patch_areas) / sizeof(patch_areas[0]);

    double index = fragmentation_index(patch_areas, patch_count);

    printf("fragmentation_index=%.6f\n", index);

    return 0;
}
