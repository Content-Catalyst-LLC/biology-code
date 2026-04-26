// Cell-condition scoring in Go.

package main

import "fmt"

type CellCondition struct {
	Name                    string
	MembraneIntegrity      float64
	MetabolicActivity      float64
	ProliferationCapacity  float64
	GenomicStability       float64
	OrganelleFunction      float64
	StressPenalty          float64
}

func cellConditionScore(item CellCondition) float64 {
	return 0.18*item.MembraneIntegrity +
		0.22*item.MetabolicActivity +
		0.18*item.ProliferationCapacity +
		0.17*item.GenomicStability +
		0.15*item.OrganelleFunction +
		0.10*(1-item.StressPenalty)
}

func conditionClass(score float64) string {
	if score >= 0.75 {
		return "strong_cell_condition"
	}
	if score >= 0.50 {
		return "moderate_cell_condition"
	}
	return "constrained_cell_condition"
}

func main() {
	cases := []CellCondition{
		{"control", 0.92, 0.88, 0.84, 0.90, 0.86, 0.12},
		{"nutrient_limited", 0.78, 0.55, 0.48, 0.82, 0.70, 0.42},
		{"hypoxic", 0.70, 0.46, 0.42, 0.76, 0.52, 0.55},
		{"drug_treated", 0.62, 0.40, 0.30, 0.68, 0.48, 0.68},
		{"membrane_stress", 0.38, 0.54, 0.44, 0.74, 0.60, 0.64},
		{"mitochondrial_stress", 0.74, 0.36, 0.40, 0.72, 0.32, 0.70},
	}

	for _, item := range cases {
		score := cellConditionScore(item)
		fmt.Printf("condition=%s cell_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
