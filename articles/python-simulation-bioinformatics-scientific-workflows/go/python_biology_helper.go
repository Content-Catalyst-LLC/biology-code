// Biological simulation and sequence helper in Go.

package main

import (
	"fmt"
	"strings"
)

func logisticGrowth(initial float64, growthRate float64, carryingCapacity float64, dt float64, steps int) []float64 {
	population := initial
	trajectory := make([]float64, 0, steps+1)

	for step := 0; step <= steps; step++ {
		trajectory = append(trajectory, population)
		growth := growthRate * population * (1.0 - population/carryingCapacity)
		population = population + dt*growth
		if population < 0 {
			population = 0
		}
	}

	return trajectory
}

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

func main() {
	trajectory := logisticGrowth(25, 0.35, 1000, 0.1, 200)
	sequence := "ATGCGCGTAATTAACCGGTTACCGTAGCTA"

	fmt.Printf("final_population=%.5f\n", trajectory[len(trajectory)-1])
	fmt.Printf("gc_content=%.5f\n", gcContent(sequence))
}
