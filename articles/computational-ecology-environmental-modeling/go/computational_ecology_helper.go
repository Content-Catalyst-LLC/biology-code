// Computational ecology helper in Go.

package main

import (
	"fmt"
	"math"
)

func logistic(x float64) float64 {
	return 1.0 / (1.0 + math.Exp(-x))
}

func habitatSuitability(temperatureC float64, precipitationMM float64, habitatQuality float64, disturbance float64) float64 {
	score := -2.0 + 0.05*temperatureC + 0.0015*precipitationMM + 2.4*habitatQuality - 2.0*disturbance
	return logistic(score)
}

func patchOccupancy(initialOccupancy float64, colonization float64, extinction float64, steps int) float64 {
	occupancy := initialOccupancy

	for step := 0; step < steps; step++ {
		occupancy = occupancy*(1.0-extinction) + (1.0-occupancy)*colonization
		if occupancy < 0 {
			occupancy = 0
		}
		if occupancy > 1 {
			occupancy = 1
		}
	}

	return occupancy
}

func runoff(precipitationMM float64, infiltrationFraction float64, runoffCoefficient float64) float64 {
	return precipitationMM * (1.0 - infiltrationFraction) * runoffCoefficient
}

func main() {
	fmt.Printf("suitability=%.5f\n", habitatSuitability(16.2, 820.0, 0.82, 0.18))
	fmt.Printf("final_occupancy=%.5f\n", patchOccupancy(0.42, 0.12, 0.08, 30))
	fmt.Printf("runoff_mm=%.5f\n", runoff(42.0, 0.62, 0.30))
}
