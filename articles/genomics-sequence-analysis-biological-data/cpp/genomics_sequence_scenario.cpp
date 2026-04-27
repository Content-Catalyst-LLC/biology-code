/*
 * Comparative genomics sequence summary implementation in C++.
 */

#include <algorithm>
#include <cctype>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

double gc_content(const std::string& sequence) {
    double valid = 0.0;
    double gc = 0.0;

    for (char character : sequence) {
        char base = static_cast<char>(std::toupper(character));

        if (base == 'A' || base == 'T') {
            valid += 1.0;
        } else if (base == 'G' || base == 'C') {
            valid += 1.0;
            gc += 1.0;
        }
    }

    if (valid == 0.0) {
        return 0.0;
    }

    return gc / valid;
}

int ambiguous_count(const std::string& sequence) {
    int count = 0;

    for (char character : sequence) {
        char base = static_cast<char>(std::toupper(character));

        if (!(base == 'A' || base == 'C' || base == 'G' || base == 'T')) {
            count++;
        }
    }

    return count;
}

int hamming_distance(const std::string& a, const std::string& b) {
    if (a.size() != b.size()) {
        throw std::invalid_argument("Sequences must have equal length.");
    }

    int distance = 0;

    for (size_t i = 0; i < a.size(); i++) {
        if (std::toupper(a[i]) != std::toupper(b[i])) {
            distance++;
        }
    }

    return distance;
}

int main() {
    std::vector<std::string> sequences = {
        "ATGCGCGTAATTAACCGGTTACCGTAGCTA",
        "ATATATGGCCNNATGCGTAACCGGTTAACTA",
        "GCGCGCGCTTATATATACCGGTTAACCGGTA"
    };

    for (const auto& sequence : sequences) {
        std::cout
            << "length=" << sequence.size()
            << " gc_content=" << gc_content(sequence)
            << " ambiguous_bases=" << ambiguous_count(sequence)
            << std::endl;
    }

    std::cout
        << "hamming_distance="
        << hamming_distance(sequences[0], "ATGCGCGTAATTAACCGGTTACCGTAACTA")
        << std::endl;

    return 0;
}
