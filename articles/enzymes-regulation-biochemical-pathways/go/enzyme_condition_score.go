// Enzyme and biochemical pathway condition scoring in Go.

package main

import "fmt"

type EnzymeCase struct {
	Name                   string
	CatalyticCapacity      float64
	SubstrateAccess        float64
	RegulatoryControl      float64
	CofactorAvailability   float64
	PathwayIntegration     float64
	EnvironmentalStability float64
	InhibitionRisk         float64
}

func enzymePathwayScore(item EnzymeCase) float64 {
	return 0.17*item.CatalyticCapacity +
		0.14*item.SubstrateAccess +
		0.15*item.RegulatoryControl +
		0.14*item.CofactorAvailability +
		0.16*item.PathwayIntegration +
		0.14*item.EnvironmentalStability +
		0.10*(1-item.InhibitionRisk)
}

func conditionClass(score float64) string {
	if score >= 0.72 {
		return "strong_enzyme_pathway_function"
	}
	if score >= 0.52 {
		return "moderate_enzyme_pathway_function"
	}
	return "constrained_or_high_uncertainty_pathway"
}

func main() {
	cases := []EnzymeCase{
		{"reference_pathway", 0.84, 0.78, 0.76, 0.80, 0.74, 0.72, 0.18},
		{"inhibited_pathway", 0.52, 0.70, 0.48, 0.68, 0.58, 0.62, 0.68},
		{"cofactor_limited_state", 0.62, 0.74, 0.66, 0.32, 0.54, 0.58, 0.42},
		{"microbial_soil_pathway", 0.78, 0.82, 0.70, 0.76, 0.84, 0.64, 0.26},
		{"thermal_stress_state", 0.50, 0.68, 0.58, 0.60, 0.52, 0.34, 0.46},
	}

	for _, item := range cases {
		score := enzymePathwayScore(item)
		fmt.Printf("case=%s enzyme_pathway_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
