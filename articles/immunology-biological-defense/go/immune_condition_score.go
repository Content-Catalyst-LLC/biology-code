// Immune condition scoring in Go.
//
// This portable example demonstrates an immune-condition score using clearance,
// activation, regulation, damage pressure, stress load, and memory support.

package main

import "fmt"

type ImmuneScenario struct {
	Name               string
	ClearanceCapacity  float64
	ActivationCapacity float64
	RegulatoryCapacity float64
	DamagePressure     float64
	StressLoad         float64
	MemorySupport      float64
}

func immuneConditionScore(s ImmuneScenario) float64 {
	return 0.22*s.ClearanceCapacity +
		0.18*s.ActivationCapacity +
		0.22*s.RegulatoryCapacity +
		0.18*s.MemorySupport -
		0.15*s.DamagePressure -
		0.15*s.StressLoad
}

func conditionClass(score float64) string {
	if score >= 0.60 {
		return "relatively-buffered"
	}
	if score >= 0.42 {
		return "stressed"
	}
	return "high-risk"
}

func main() {
	scenarios := []ImmuneScenario{
		{"baseline", 0.75, 0.70, 0.72, 0.25, 0.25, 0.70},
		{"high_pathogen_pressure", 0.70, 0.75, 0.65, 0.45, 0.40, 0.68},
		{"immune_suppression", 0.45, 0.40, 0.70, 0.30, 0.55, 0.50},
		{"hyperinflammatory", 0.78, 0.90, 0.35, 0.75, 0.50, 0.65},
		{"recovery_supported", 0.82, 0.74, 0.84, 0.20, 0.18, 0.78},
	}

	for _, scenario := range scenarios {
		score := immuneConditionScore(scenario)
		fmt.Printf("scenario=%s immune_condition_score=%.3f condition_class=%s\n", scenario.Name, score, conditionClass(score))
	}
}
