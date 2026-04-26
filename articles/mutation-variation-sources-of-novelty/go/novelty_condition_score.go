// Novelty condition scoring in Go.

package main

import "fmt"

type NoveltyCase struct {
	Name                    string
	MutationSupply          float64
	StandingVariation       float64
	RecombinationPotential  float64
	RegulatoryFlexibility   float64
	DevelopmentalModularity float64
	EcologicalOpportunity   float64
	ConstraintRisk          float64
}

func noveltyScore(item NoveltyCase) float64 {
	return 0.15*item.MutationSupply +
		0.17*item.StandingVariation +
		0.14*item.RecombinationPotential +
		0.15*item.RegulatoryFlexibility +
		0.15*item.DevelopmentalModularity +
		0.14*item.EcologicalOpportunity +
		0.10*(1-item.ConstraintRisk)
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "high_novelty_potential"
	}
	if score >= 0.50 {
		return "moderate_novelty_potential"
	}
	return "constrained_or_low_novelty_potential"
}

func main() {
	cases := []NoveltyCase{
		{"reference_population", 0.58, 0.74, 0.66, 0.62, 0.61, 0.55, 0.22},
		{"bottlenecked_population", 0.31, 0.28, 0.32, 0.40, 0.45, 0.48, 0.68},
		{"microbial_stress_system", 0.88, 0.69, 0.54, 0.76, 0.52, 0.84, 0.30},
		{"crop_breeding_panel", 0.63, 0.81, 0.79, 0.58, 0.56, 0.61, 0.24},
	}

	for _, item := range cases {
		score := noveltyScore(item)
		fmt.Printf("case=%s novelty_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
