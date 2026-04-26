// Population-genetic condition scoring in Go.

package main

import "fmt"

type PopulationCase struct {
	Name                  string
	Heterozygosity         float64
	AllelicRichness       float64
	GeneFlow              float64
	FragmentationPressure float64
	BottleneckRisk        float64
	AdaptiveCapacity      float64
}

func conditionScore(item PopulationCase) float64 {
	return 0.18*item.Heterozygosity +
		0.18*item.AllelicRichness +
		0.16*item.GeneFlow +
		0.16*(1-item.FragmentationPressure) +
		0.16*(1-item.BottleneckRisk) +
		0.16*item.AdaptiveCapacity
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "strong"
	}
	if score >= 0.50 {
		return "moderate"
	}
	return "at_risk"
}

func main() {
	cases := []PopulationCase{
		{"reference_metapopulation", 0.72, 0.68, 0.66, 0.22, 0.18, 0.70},
		{"isolated_fragment", 0.38, 0.35, 0.22, 0.78, 0.74, 0.31},
		{"restoration_source_mix", 0.61, 0.58, 0.52, 0.35, 0.30, 0.62},
		{"pathogen_resistance_pool", 0.82, 0.74, 0.48, 0.28, 0.25, 0.86},
	}

	for _, item := range cases {
		score := conditionScore(item)
		fmt.Printf("case=%s population_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
