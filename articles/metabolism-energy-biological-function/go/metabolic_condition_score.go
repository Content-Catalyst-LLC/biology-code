// Metabolic condition scoring in Go.

package main

import "fmt"

type MetabolicCase struct {
	Name                  string
	SubstrateAvailability float64
	EnergyConversion      float64
	RedoxBalance          float64
	GrowthCapacity        float64
	MaintenanceResilience float64
	PathwayIntegration    float64
	StressPenalty         float64
}

func metabolicConditionScore(item MetabolicCase) float64 {
	return 0.16*item.SubstrateAvailability +
		0.17*item.EnergyConversion +
		0.15*item.RedoxBalance +
		0.14*item.GrowthCapacity +
		0.14*item.MaintenanceResilience +
		0.14*item.PathwayIntegration +
		0.10*(1-item.StressPenalty)
}

func conditionClass(score float64) string {
	if score >= 0.72 {
		return "strong_metabolic_function"
	}
	if score >= 0.52 {
		return "moderate_metabolic_function"
	}
	return "constrained_or_high_uncertainty_metabolism"
}

func main() {
	cases := []MetabolicCase{
		{"reference_cell_state", 0.84, 0.82, 0.78, 0.80, 0.74, 0.76, 0.18},
		{"nutrient_limited_state", 0.38, 0.70, 0.66, 0.42, 0.62, 0.58, 0.40},
		{"hypoxic_state", 0.72, 0.40, 0.36, 0.46, 0.58, 0.52, 0.62},
		{"microbial_soil_system", 0.78, 0.74, 0.70, 0.72, 0.80, 0.84, 0.26},
		{"plant_stress_state", 0.62, 0.68, 0.64, 0.58, 0.76, 0.72, 0.34},
	}

	for _, item := range cases {
		score := metabolicConditionScore(item)
		fmt.Printf("case=%s metabolic_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
