// Evolutionary condition scoring in Go.

package main

import "fmt"

type EvolutionCase struct {
	Name                 string
	StandingVariation    float64
	PhylogeneticSignal   float64
	FossilRecordStrength float64
	EnvironmentalChange  float64
	ExtinctionPressure   float64
	AdaptiveCapacity     float64
}

func conditionScore(item EvolutionCase) float64 {
	return 0.17*item.StandingVariation +
		0.17*item.PhylogeneticSignal +
		0.16*item.FossilRecordStrength +
		0.16*(1-item.EnvironmentalChange) +
		0.17*(1-item.ExtinctionPressure) +
		0.17*item.AdaptiveCapacity
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "strong_evolutionary_continuity"
	}
	if score >= 0.50 {
		return "moderate_evolutionary_continuity"
	}
	return "constrained_or_at_risk"
}

func main() {
	cases := []EvolutionCase{
		{"reference_lineage", 0.72, 0.78, 0.70, 0.34, 0.22, 0.68},
		{"fragmented_relict_group", 0.38, 0.74, 0.82, 0.71, 0.76, 0.31},
		{"rapidly_evolving_pathogen", 0.88, 0.52, 0.20, 0.63, 0.35, 0.86},
		{"well_sampled_fossil_clade", 0.55, 0.66, 0.94, 0.42, 0.30, 0.52},
	}

	for _, item := range cases {
		score := conditionScore(item)
		fmt.Printf("case=%s evolutionary_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
