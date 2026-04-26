// Selection condition scoring in Go.

package main

import "fmt"

type SelectionCase struct {
	Name                 string
	StandingVariation    float64
	SelectionStrength    float64
	EnvironmentalMatch   float64
	DemographicStability float64
	GeneFlowSupport      float64
	ConstraintRisk       float64
}

func conditionScore(item SelectionCase) float64 {
	return 0.18*item.StandingVariation +
		0.18*item.SelectionStrength +
		0.18*item.EnvironmentalMatch +
		0.16*item.DemographicStability +
		0.14*item.GeneFlowSupport +
		0.16*(1-item.ConstraintRisk)
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "high_adaptive_potential"
	}
	if score >= 0.50 {
		return "moderate_adaptive_potential"
	}
	return "constrained_or_at_risk"
}

func main() {
	cases := []SelectionCase{
		{"reference_population", 0.72, 0.58, 0.70, 0.74, 0.62, 0.22},
		{"fragmented_adaptation_lag", 0.38, 0.76, 0.34, 0.40, 0.20, 0.71},
		{"pathogen_resistance_system", 0.84, 0.88, 0.79, 0.68, 0.55, 0.25},
		{"restoration_target_site", 0.61, 0.52, 0.57, 0.60, 0.48, 0.36},
	}

	for _, item := range cases {
		score := conditionScore(item)
		fmt.Printf("case=%s selection_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
