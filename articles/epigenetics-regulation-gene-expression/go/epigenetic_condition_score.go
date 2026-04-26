// Epigenetic condition scoring in Go.

package main

import "fmt"

type EpigeneticCase struct {
	Name                        string
	ExpressionStability         float64
	AccessibilitySignal         float64
	MethylationQuality          float64
	StateMemory                 float64
	EnvironmentalResponsiveness float64
	BatchRisk                   float64
}

func conditionScore(item EpigeneticCase) float64 {
	return 0.18*item.ExpressionStability +
		0.18*item.AccessibilitySignal +
		0.16*item.MethylationQuality +
		0.16*item.StateMemory +
		0.16*item.EnvironmentalResponsiveness +
		0.16*(1-item.BatchRisk)
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "strong_regulatory_signal"
	}
	if score >= 0.50 {
		return "moderate_regulatory_signal"
	}
	return "weak_or_high_uncertainty_signal"
}

func main() {
	cases := []EpigeneticCase{
		{"reference_cell_system", 0.72, 0.76, 0.70, 0.74, 0.62, 0.20},
		{"stressed_plant_tissue", 0.58, 0.68, 0.61, 0.52, 0.86, 0.28},
		{"tumor_like_dysregulation", 0.31, 0.82, 0.77, 0.34, 0.66, 0.36},
		{"microbial_stress_response", 0.49, 0.43, 0.22, 0.41, 0.88, 0.32},
	}

	for _, item := range cases {
		score := conditionScore(item)
		fmt.Printf("case=%s epigenetic_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
