// Speciation condition scoring in Go.

package main

import "fmt"

type SpeciationCase struct {
	Name                   string
	AlleleDivergence       float64
	ReproductiveIsolation  float64
	EcologicalDifference   float64
	PhylogeneticResolution float64
	GeneFlowRisk           float64
	LineageDistinctiveness float64
}

func conditionScore(item SpeciationCase) float64 {
	return 0.20*item.AlleleDivergence +
		0.20*item.ReproductiveIsolation +
		0.18*item.EcologicalDifference +
		0.16*item.PhylogeneticResolution +
		0.14*(1-item.GeneFlowRisk) +
		0.12*item.LineageDistinctiveness
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "strong_lineage_separation"
	}
	if score >= 0.50 {
		return "partial_or_emerging_separation"
	}
	return "weak_or_unresolved_separation"
}

func main() {
	cases := []SpeciationCase{
		{"reference_pair", 0.68, 0.72, 0.66, 0.78, 0.20, 0.74},
		{"hybrid_zone", 0.46, 0.38, 0.55, 0.63, 0.72, 0.50},
		{"island_radiation", 0.74, 0.69, 0.82, 0.70, 0.18, 0.80},
		{"microbial_complex", 0.51, 0.30, 0.61, 0.52, 0.45, 0.58},
	}

	for _, item := range cases {
		score := conditionScore(item)
		fmt.Printf("case=%s speciation_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
