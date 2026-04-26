// Material-condition scoring in Go.

package main

import "fmt"

type MaterialConditionCase struct {
	Name                string
	WaterAvailability   float64
	OsmoticStability    float64
	EnergyAvailability  float64
	OxygenSupport       float64
	ThermalSuitability  float64
	PHStability         float64
	StressPenalty       float64
}

func materialConditionScore(item MaterialConditionCase) float64 {
	return 0.17*item.WaterAvailability +
		0.15*item.OsmoticStability +
		0.17*item.EnergyAvailability +
		0.14*item.OxygenSupport +
		0.13*item.ThermalSuitability +
		0.14*item.PHStability +
		0.10*(1-item.StressPenalty)
}

func conditionClass(score float64) string {
	if score >= 0.72 {
		return "strong_material_conditions"
	}
	if score >= 0.52 {
		return "moderate_material_conditions"
	}
	return "constrained_or_high_uncertainty_conditions"
}

func main() {
	cases := []MaterialConditionCase{
		{"reference_cell_state", 0.86, 0.82, 0.84, 0.80, 0.78, 0.82, 0.18},
		{"dehydration_state", 0.34, 0.46, 0.68, 0.78, 0.72, 0.70, 0.58},
		{"hypoxic_state", 0.78, 0.74, 0.40, 0.32, 0.70, 0.68, 0.62},
		{"marine_acidification_state", 0.82, 0.70, 0.66, 0.72, 0.68, 0.38, 0.55},
		{"thermal_stress_state", 0.74, 0.70, 0.62, 0.68, 0.30, 0.66, 0.64},
		{"plant_drought_state", 0.38, 0.48, 0.58, 0.74, 0.66, 0.70, 0.60},
	}

	for _, item := range cases {
		score := materialConditionScore(item)
		fmt.Printf("case=%s material_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
