// Living-order condition scoring in Go.

package main

import "fmt"

type LivingOrderCase struct {
	Name                      string
	HomeostaticRegulation     float64
	MetabolicThroughput       float64
	StructuralIntegration     float64
	DevelopmentalCoordination float64
	InformationContinuity     float64
	EcologicalRelation        float64
	StressPenalty             float64
}

func livingOrderScore(item LivingOrderCase) float64 {
	return 0.17*item.HomeostaticRegulation +
		0.16*item.MetabolicThroughput +
		0.15*item.StructuralIntegration +
		0.13*item.DevelopmentalCoordination +
		0.15*item.InformationContinuity +
		0.14*item.EcologicalRelation +
		0.10*(1-item.StressPenalty)
}

func conditionClass(score float64) string {
	if score >= 0.72 {
		return "strong_living_order"
	}
	if score >= 0.52 {
		return "moderate_living_order"
	}
	return "constrained_or_high_uncertainty_living_order"
}

func main() {
	cases := []LivingOrderCase{
		{"reference_living_system", 0.86, 0.84, 0.82, 0.78, 0.88, 0.80, 0.18},
		{"metabolic_stress_state", 0.68, 0.38, 0.70, 0.66, 0.80, 0.72, 0.58},
		{"regulatory_failure_state", 0.34, 0.66, 0.70, 0.62, 0.78, 0.68, 0.64},
		{"developmental_disruption_state", 0.72, 0.70, 0.66, 0.36, 0.76, 0.68, 0.60},
		{"ecosystem_fragmentation_state", 0.70, 0.72, 0.64, 0.66, 0.74, 0.34, 0.70},
		{"recovery_state", 0.78, 0.76, 0.74, 0.72, 0.80, 0.76, 0.32},
	}

	for _, item := range cases {
		score := livingOrderScore(item)
		fmt.Printf("case=%s living_order_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
