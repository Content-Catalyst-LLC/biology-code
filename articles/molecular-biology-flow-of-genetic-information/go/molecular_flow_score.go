// Molecular information-flow scoring in Go.

package main

import "fmt"

type MolecularFlowCase struct {
	Name                 string
	ReplicationFidelity  float64
	TranscriptionSignal  float64
	RNAProcessing        float64
	TranslationSupport   float64
	RepairCapacity       float64
	RegulatoryContext    float64
	ExpressionNoiseRisk  float64
}

func molecularFlowScore(item MolecularFlowCase) float64 {
	return 0.16*item.ReplicationFidelity +
		0.15*item.TranscriptionSignal +
		0.14*item.RNAProcessing +
		0.14*item.TranslationSupport +
		0.16*item.RepairCapacity +
		0.15*item.RegulatoryContext +
		0.10*(1-item.ExpressionNoiseRisk)
}

func conditionClass(score float64) string {
	if score >= 0.72 {
		return "strong_molecular_information_flow"
	}
	if score >= 0.52 {
		return "moderate_molecular_information_flow"
	}
	return "constrained_or_high_uncertainty_information_flow"
}

func main() {
	cases := []MolecularFlowCase{
		{"reference_cell_state", 0.86, 0.74, 0.78, 0.80, 0.82, 0.76, 0.18},
		{"stress_response_state", 0.70, 0.90, 0.66, 0.68, 0.64, 0.84, 0.36},
		{"repair_deficient_state", 0.42, 0.58, 0.54, 0.60, 0.28, 0.52, 0.72},
		{"high_expression_program", 0.74, 0.92, 0.72, 0.84, 0.66, 0.80, 0.28},
		{"microbial_adaptation_state", 0.68, 0.78, 0.62, 0.70, 0.58, 0.74, 0.40},
	}

	for _, item := range cases {
		score := molecularFlowScore(item)
		fmt.Printf("case=%s molecular_flow_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
