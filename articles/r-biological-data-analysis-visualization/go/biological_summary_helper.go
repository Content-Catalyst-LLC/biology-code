// Biological summary helper in Go.

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

func shannonDiversity(counts []float64) float64 {
	total := 0.0
	for _, c := range counts {
		if c > 0 {
			total += c
		}
	}

	h := 0.0
	for _, c := range counts {
		if c > 0 {
			p := c / total
			h += -p * math.Log(p)
		}
	}

	return h
}

func main() {
	values := []float64{10.2, 10.5, 10.1, 10.4, 10.3, 10.6}
	counts := []float64{18, 7, 3, 0}

	meanValue := mean(values)
	sdValue := sampleSD(values)

	fmt.Printf("mean=%.5f\n", meanValue)
	fmt.Printf("sd=%.5f\n", sdValue)
	fmt.Printf("cv=%.5f\n", sdValue/meanValue)
	fmt.Printf("shannon=%.5f\n", shannonDiversity(counts))
}
