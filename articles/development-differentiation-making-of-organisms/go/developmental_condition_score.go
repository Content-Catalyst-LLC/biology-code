// Developmental condition scoring in Go.

package main

import "fmt"

type DevelopmentalCase struct {
	Name                   string
	GrowthCoherence        float64
	DifferentiationSignal  float64
	PatterningSignal       float64
	MorphogenesisQuality   float64
	EnvironmentalStability float64
	PerturbationRisk       float64
}

func conditionScore(item DevelopmentalCase) float64 {
	return 0.18*item.GrowthCoherence +
		0.18*item.DifferentiationSignal +
		0.16*item.PatterningSignal +
		0.16*item.MorphogenesisQuality +
		0.16*item.EnvironmentalStability +
		0.16*(1-item.PerturbationRisk)
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "strong_developmental_coherence"
	}
	if score >= 0.50 {
		return "moderate_developmental_coherence"
	}
	return "developmentally_constrained_or_at_risk"
}

func main() {
	cases := []DevelopmentalCase{
		{"reference_embryoid_system", 0.74, 0.78, 0.72, 0.70, 0.68, 0.20},
		{"stressed_larval_system", 0.42, 0.55, 0.48, 0.44, 0.30, 0.72},
		{"restoration_seedling_stage", 0.61, 0.58, 0.52, 0.50, 0.46, 0.38},
		{"organoid_screening_model", 0.68, 0.82, 0.63, 0.59, 0.74, 0.31},
	}

	for _, item := range cases {
		score := conditionScore(item)
		fmt.Printf("case=%s developmental_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
