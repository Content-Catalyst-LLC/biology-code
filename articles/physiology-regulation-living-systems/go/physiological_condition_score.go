// Physiological condition scoring in Go.
//
// This portable example demonstrates a regulatory-condition score using
// feedback, effector capacity, signal integrity, stress load, environmental
// pressure, and recovery support.

package main

import "fmt"

type PhysiologicalScenario struct {
	Name                  string
	FeedbackCapacity      float64
	EffectorCapacity      float64
	SignalIntegrity       float64
	StressLoad            float64
	EnvironmentalPressure float64
	RecoverySupport       float64
}

func conditionScore(s PhysiologicalScenario) float64 {
	return 0.22*s.FeedbackCapacity +
		0.20*s.EffectorCapacity +
		0.20*s.SignalIntegrity +
		0.18*s.RecoverySupport -
		0.12*s.StressLoad -
		0.12*s.EnvironmentalPressure
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
	scenarios := []PhysiologicalScenario{
		{"baseline", 0.76, 0.74, 0.78, 0.25, 0.25, 0.72},
		{"high_heat_stress", 0.70, 0.68, 0.72, 0.55, 0.60, 0.60},
		{"dehydration_pressure", 0.66, 0.62, 0.70, 0.50, 0.58, 0.55},
		{"weak_effector_capacity", 0.72, 0.45, 0.74, 0.35, 0.40, 0.58},
		{"recovery_supported", 0.82, 0.80, 0.84, 0.20, 0.18, 0.82},
	}

	for _, scenario := range scenarios {
		score := conditionScore(scenario)
		fmt.Printf("scenario=%s physiological_condition_score=%.3f condition_class=%s\n", scenario.Name, score, conditionClass(score))
	}
}
