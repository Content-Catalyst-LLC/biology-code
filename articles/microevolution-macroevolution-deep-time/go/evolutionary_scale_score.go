// Evolutionary-scale scoring in Go.

package main

import "fmt"

type EvolutionaryScaleCase struct {
	Name                    string
	PopulationVariation     float64
	LineageDistinctiveness  float64
	FossilRecordStrength    float64
	PhylogeneticResolution  float64
	ExtinctionPressure      float64
	AdaptiveCapacity       float64
}

func scaleScore(item EvolutionaryScaleCase) float64 {
	return 0.18*item.PopulationVariation +
		0.18*item.LineageDistinctiveness +
		0.16*item.FossilRecordStrength +
		0.16*item.PhylogeneticResolution +
		0.16*(1-item.ExtinctionPressure) +
		0.16*item.AdaptiveCapacity
}

func interpretiveClass(score float64) string {
	if score < 0.50 {
		return "limited"
	}
	if score < 0.70 {
		return "moderate"
	}
	return "strong"
}

func main() {
	cases := []EvolutionaryScaleCase{
		{"reference_clade", 0.72, 0.66, 0.80, 0.78, 0.22, 0.70},
		{"fragmented_population_complex", 0.48, 0.74, 0.42, 0.60, 0.66, 0.38},
		{"well_sampled_fossil_group", 0.51, 0.62, 0.91, 0.70, 0.35, 0.54},
		{"rapidly_evolving_pathogen", 0.88, 0.41, 0.20, 0.82, 0.30, 0.86},
	}

	for _, item := range cases {
		score := scaleScore(item)
		fmt.Printf("case=%s evolutionary_scale_score=%.3f interpretive_class=%s\n", item.Name, score, interpretiveClass(score))
	}
}
