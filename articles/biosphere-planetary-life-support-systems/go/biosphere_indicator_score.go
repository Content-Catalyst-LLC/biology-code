// Biosphere indicator scoring in Go.
//
// This portable example demonstrates a simple weighted functional-integrity
// scoring workflow without external dependencies.

package main

import "fmt"

type BiosphereUnit struct {
	Name                string
	PrimaryProduction   float64
	WaterRegulation     float64
	NutrientRetention   float64
	HabitatComplexity   float64
	Connectivity        float64
	DisturbancePressure float64
	BiodiversitySignal  float64
}

func functionalIntegrity(unit BiosphereUnit) float64 {
	return 0.20*unit.PrimaryProduction +
		0.18*unit.WaterRegulation +
		0.18*unit.NutrientRetention +
		0.18*unit.HabitatComplexity +
		0.12*unit.Connectivity +
		0.14*unit.BiodiversitySignal -
		0.20*unit.DisturbancePressure
}

func riskClass(score float64) string {
	if score >= 0.70 {
		return "stable-to-watch"
	}
	if score >= 0.50 {
		return "stressed"
	}
	return "high-risk"
}

func main() {
	units := []BiosphereUnit{
		{"A", 0.86, 0.82, 0.79, 0.91, 0.84, 0.24, 0.88},
		{"B", 0.73, 0.69, 0.70, 0.64, 0.51, 0.41, 0.66},
		{"C", 0.61, 0.58, 0.49, 0.42, 0.38, 0.72, 0.44},
		{"D", 0.91, 0.88, 0.85, 0.94, 0.90, 0.18, 0.92},
		{"E", 0.67, 0.63, 0.57, 0.55, 0.48, 0.56, 0.59},
	}

	for _, unit := range units {
		score := functionalIntegrity(unit)
		fmt.Printf("unit=%s functional_integrity=%.3f risk_class=%s\n", unit.Name, score, riskClass(score))
	}
}
