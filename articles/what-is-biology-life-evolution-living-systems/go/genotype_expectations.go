// Hardy-Weinberg genotype expectations in Go.

package main

import "fmt"

func hardyWeinberg(p float64) (float64, float64, float64) {
	q := 1.0 - p
	return p * p, 2.0 * p * q, q * q
}

func main() {
	cases := []float64{0.70, 0.50, 0.25, 0.90}

	for _, p := range cases {
		aaCapital, heterozygote, aaLower := hardyWeinberg(p)
		fmt.Printf("p=%.3f AA=%.3f Aa=%.3f aa=%.3f\n", p, aaCapital, heterozygote, aaLower)
	}
}
