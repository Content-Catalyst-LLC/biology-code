// Statistics and measurement helper in Go.

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
	for _, u := range components {
		sumsq += u * u
	}
	return math.Sqrt(sumsq)
}

func main() {
	values := []float64{10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4, 11.3, 10.7}
	m := mean(values)
	sd := sampleSD(values)
	se := sd / math.Sqrt(float64(len(values)))

	components := []float64{0.12, 0.08, 0.15, 0.06, 0.05}
	uc := combinedUncertainty(components)

	fmt.Printf("mean=%.5f\n", m)
	fmt.Printf("standard_deviation=%.5f\n", sd)
	fmt.Printf("standard_error=%.5f\n", se)
	fmt.Printf("ci_lower=%.5f\n", m-1.96*se)
	fmt.Printf("ci_upper=%.5f\n", m+1.96*se)
	fmt.Printf("combined_standard_uncertainty=%.5f\n", uc)
	fmt.Printf("expanded_uncertainty=%.5f\n", 2.0*uc)
}
