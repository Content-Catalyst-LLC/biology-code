// Molecular condition scoring in Go.

package main

import "fmt"

type MolecularCase struct {
	Name                string
	ReplicationFidelity float64
	TranscriptionSignal float64
	RNAStability        float64
	TranslationSupport  float64
	RepairCapacity      float64
	RegulatoryContext   float64
	DamageRisk          float64
}

func molecularScore(item MolecularCase) float64 {
	return 0.16*item.ReplicationFidelity +
		0.16*item.TranscriptionSignal +
		0.14*item.RNAStability +
		0.14*item.TranslationSupport +
		0.16*item.RepairCapacity +
		0.14*item.RegulatoryContext +
		0.10*(1-item.DamageRisk)
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "strong_molecular_continuity_and_response"
	}
	if score >= 0.50 {
		return "moderate_molecular_continuity_and_response"
	}
	return "molecularly_constrained_or_high_uncertainty"
}

func main() {
	cases := []MolecularCase{
		{"reference_cell_state", 0.86, 0.72, 0.70, 0.78, 0.82, 0.74, 0.18},
		{"stress_response_state", 0.70, 0.88, 0.46, 0.66, 0.64, 0.82, 0.38},
		{"damage_repair_deficient", 0.42, 0.58, 0.54, 0.61, 0.28, 0.50, 0.77},
		{"high_expression_program", 0.74, 0.92, 0.69, 0.84, 0.66, 0.79, 0.29},
	}

	for _, item := range cases {
		score := molecularScore(item)
		fmt.Printf("case=%s molecular_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
