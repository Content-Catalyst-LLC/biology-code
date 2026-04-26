// Biomolecular condition scoring in Go.

package main

import "fmt"

type BiomolecularCase struct {
	Name                   string
	CarbohydrateSupport    float64
	LipidBoundaryFunction  float64
	ProteinFunction        float64
	NucleicAcidIntegrity   float64
	MetaboliteBalance      float64
	CofactorAvailability   float64
	StressPenalty          float64
}

func biomolecularConditionScore(item BiomolecularCase) float64 {
	return 0.14*item.CarbohydrateSupport +
		0.15*item.LipidBoundaryFunction +
		0.18*item.ProteinFunction +
		0.17*item.NucleicAcidIntegrity +
		0.14*item.MetaboliteBalance +
		0.12*item.CofactorAvailability +
		0.10*(1-item.StressPenalty)
}

func conditionClass(score float64) string {
	if score >= 0.72 {
		return "strong_biomolecular_function"
	}
	if score >= 0.52 {
		return "moderate_biomolecular_function"
	}
	return "constrained_or_high_uncertainty_biomolecular_state"
}

func main() {
	cases := []BiomolecularCase{
		{"reference_cell_state", 0.84, 0.82, 0.86, 0.88, 0.80, 0.78, 0.18},
		{"energy_storage_deficit", 0.42, 0.76, 0.74, 0.82, 0.58, 0.70, 0.48},
		{"membrane_disruption_state", 0.72, 0.38, 0.68, 0.80, 0.62, 0.66, 0.60},
		{"protein_misfolding_state", 0.76, 0.72, 0.34, 0.82, 0.60, 0.58, 0.66},
		{"genomic_damage_state", 0.78, 0.74, 0.70, 0.36, 0.64, 0.62, 0.70},
		{"metabolic_cofactor_limited_state", 0.70, 0.72, 0.62, 0.78, 0.42, 0.30, 0.58},
	}

	for _, item := range cases {
		score := biomolecularConditionScore(item)
		fmt.Printf("case=%s biomolecular_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
