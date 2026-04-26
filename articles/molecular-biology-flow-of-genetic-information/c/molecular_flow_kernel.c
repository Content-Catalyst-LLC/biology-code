/*
 * Compact molecular information-flow kernel in C.
 */

#include <math.h>
#include <stdio.h>
#include <string.h>

double transcript_decay(double m0, double k, double t) {
    return m0 * exp(-k * t);
}

double half_life(double k) {
    return log(2.0) / k;
}

double jukes_cantor(double p) {
    if (p >= 0.75) {
        return NAN;
    }

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * p);
}

double gc_fraction(const char *seq) {
    int gc = 0;
    int length = strlen(seq);

    for (int i = 0; i < length; i++) {
        if (seq[i] == 'G' || seq[i] == 'C') {
            gc++;
        }
    }

    return (double)gc / (double)length;
}

double mutation_rate(double mutations, double genomes, double sites, double generations) {
    return mutations / (genomes * sites * generations);
}

int main(void) {
    const char *seq = "ATGCTAGCTAACGGTACCTA";
    double k = log(4.0) / 4.0;
    double log2fc = log(160.0 / 40.0) / log(2.0);
    double p_distance = 2.0 / 20.0;

    printf("transcript_at_4h=%.6f\n", transcript_decay(100.0, k, 4.0));
    printf("half_life_h=%.6f\n", half_life(k));
    printf("gc_fraction=%.6f\n", gc_fraction(seq));
    printf("jukes_cantor=%.6f\n", jukes_cantor(p_distance));
    printf("log2fc=%.6f\n", log2fc);
    printf("mutation_rate=%.12f\n", mutation_rate(12.0, 1000.0, 100000.0, 1.0));

    return 0;
}
