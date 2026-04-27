// Genomics sequence helper in Go.

package main

import (
	"fmt"
	"strings"
)

func gcContent(sequence string) float64 {
	valid := 0.0
	gc := 0.0

	for _, base := range strings.ToUpper(sequence) {
		switch base {
		case 'A', 'T':
			valid += 1
		case 'G', 'C':
			valid += 1
			gc += 1
		}
	}

	if valid == 0 {
		return 0
	}

	return gc / valid
}

func ambiguousCount(sequence string) int {
	count := 0

	for _, base := range strings.ToUpper(sequence) {
		if base != 'A' && base != 'C' && base != 'G' && base != 'T' {
			count++
		}
	}

	return count
}

func hammingDistance(a string, b string) int {
	if len(a) != len(b) {
		panic("sequences must have equal length")
	}

	distance := 0
	a = strings.ToUpper(a)
	b = strings.ToUpper(b)

	for i := 0; i < len(a); i++ {
		if a[i] != b[i] {
			distance++
		}
	}

	return distance
}

func main() {
	sequenceA := "ATGCGCGTAATTAACCGGTTACCGTAGCTA"
	sequenceB := "ATGCGCGTAATTAACCGGTTACCGTAACTA"

	fmt.Printf("sequence_length=%d\n", len(sequenceA))
	fmt.Printf("gc_content=%.5f\n", gcContent(sequenceA))
	fmt.Printf("ambiguous_bases=%d\n", ambiguousCount(sequenceA))
	fmt.Printf("hamming_distance=%d\n", hammingDistance(sequenceA, sequenceB))
}
