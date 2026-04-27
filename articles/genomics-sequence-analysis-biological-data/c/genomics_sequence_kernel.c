/*
 * Compact genomics sequence statistics kernel in C.
 */

#include <ctype.h>
#include <stdio.h>
#include <string.h>

double gc_content(const char *sequence) {
    double valid = 0.0;
    double gc = 0.0;

    for (size_t i = 0; i < strlen(sequence); i++) {
        char base = toupper(sequence[i]);

        if (base == 'A' || base == 'T') {
            valid += 1.0;
        } else if (base == 'G' || base == 'C') {
            valid += 1.0;
            gc += 1.0;
        }
    }

    if (valid == 0.0) return 0.0;
    return gc / valid;
}

int ambiguous_count(const char *sequence) {
    int count = 0;

    for (size_t i = 0; i < strlen(sequence); i++) {
        char base = toupper(sequence[i]);

        if (!(base == 'A' || base == 'C' || base == 'G' || base == 'T')) {
            count++;
        }
    }

    return count;
}

int hamming_distance(const char *a, const char *b) {
    int distance = 0;

    if (strlen(a) != strlen(b)) {
        return -1;
    }

    for (size_t i = 0; i < strlen(a); i++) {
        if (toupper(a[i]) != toupper(b[i])) {
            distance++;
        }
    }

    return distance;
}

int main(void) {
    const char *sequence_a = "ATGCGCGTAATTAACCGGTTACCGTAGCTA";
    const char *sequence_b = "ATGCGCGTAATTAACCGGTTACCGTAACTA";

    printf("sequence_length=%lu\n", strlen(sequence_a));
    printf("gc_content=%.6f\n", gc_content(sequence_a));
    printf("ambiguous_bases=%d\n", ambiguous_count(sequence_a));
    printf("hamming_distance=%d\n", hamming_distance(sequence_a, sequence_b));

    return 0;
}
