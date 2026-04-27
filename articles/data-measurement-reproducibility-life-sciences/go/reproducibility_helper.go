// Measurement and reproducibility helper in Go.

package main

import (
	"fmt"
	"math"
)

func mean(values []float64) float64 {
	total := 0.0
	for _, v := range values {
		total += v
	}
	return total / float64(len(values))
}

func sampleSD(values []float64) float64 {
	m := mean(values)
	sumsq := 0.0
	for _, v := range values {
		sumsq += math.Pow(v-m, 2)
	}
	return math.Sqrt(sumsq / float64(len(values)-1))
}

func combinedUncertainty(components []float64) float64 {
	sumsq := 0.0
	for _, v := range components {
		sumsq += v * v
	}
	return math.Sqrt(sumsq)
}

func main() {
	values := []float64{10.2, 10.5, 10.1, 10.4, 10.8, 10.7, 10.6, 10.3, 10.9, 10.4}
	components := []float64{0.08, 0.05, 0.11, 0.06}

	meanValue := mean(values)
	sdValue := sampleSD(values)
	cv := sdValue / meanValue
	uc := combinedUncertainty(components)

	fmt.Printf("mean_value=%.5f\n", meanValue)
	fmt.Printf("sample_sd=%.5f\n", sdValue)
	fmt.Printf("coefficient_of_variation=%.5f\n", cv)
	fmt.Printf("combined_standard_uncertainty=%.5f\n", uc)
	fmt.Printf("expanded_uncertainty=%.5f\n", 2.0*uc)
}
