// Biostatistics and experimental-design helper in Go.

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

func main() {
	control := []float64{10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4}
	treated := []float64{12.1, 11.7, 12.4, 11.9, 12.0, 12.6, 11.8, 12.3}

	mean0 := mean(control)
	mean1 := mean(treated)
	sd0 := sampleSD(control)
	sd1 := sampleSD(treated)

	n0 := float64(len(control))
	n1 := float64(len(treated))

	pooledSD := math.Sqrt(((n0-1)*sd0*sd0 + (n1-1)*sd1*sd1) / (n0 + n1 - 2))
	difference := mean1 - mean0
	effectSize := difference / pooledSD
	seDifference := math.Sqrt(sd0*sd0/n0 + sd1*sd1/n1)
	approxN := 2 * math.Pow(1.96+0.84, 2) / math.Pow(0.8, 2)

	fmt.Printf("control_mean=%.5f\n", mean0)
	fmt.Printf("treated_mean=%.5f\n", mean1)
	fmt.Printf("mean_difference=%.5f\n", difference)
	fmt.Printf("pooled_sd=%.5f\n", pooledSD)
	fmt.Printf("effect_size_d=%.5f\n", effectSize)
	fmt.Printf("se_difference=%.5f\n", seDifference)
	fmt.Printf("approx_n_per_group_for_d_0_8=%.3f\n", approxN)
}
