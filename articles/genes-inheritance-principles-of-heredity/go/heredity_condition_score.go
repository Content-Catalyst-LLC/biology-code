// Heredity condition scoring in Go.

package main

import "fmt"

type HeredityCase struct {
	Name                     string
	StandingVariation        float64
	InheritanceClarity       float64
	RecombinationInformation float64
	PopulationSize           float64
	GenotypeQuality          float64
	EnvironmentalContext     float64
	InbreedingRisk           float64
}

func heredityScore(item HeredityCase) float64 {
	return 0.18*item.StandingVariation +
		0.14*item.InheritanceClarity +
		0.12*item.RecombinationInformation +
		0.15*item.PopulationSize +
		0.15*item.GenotypeQuality +
		0.14*item.EnvironmentalContext +
		0.12*(1-item.InbreedingRisk)
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "strong_hereditary_resilience"
	}
	if score >= 0.50 {
		return "moderate_hereditary_resilience"
	}
	return "constrained_or_high_risk_hereditary_system"
}

func main() {
	cases := []HeredityCase{
		{"reference_population", 0.76, 0.78, 0.64, 0.72, 0.81, 0.70, 0.18},
		{"bottlenecked_population", 0.32, 0.66, 0.40, 0.28, 0.70, 0.58, 0.72},
		{"crop_breeding_panel", 0.82, 0.74, 0.70, 0.68, 0.76, 0.62, 0.22},
		{"restoration_seed_source", 0.58, 0.60, 0.44, 0.52, 0.66, 0.80, 0.36},
	}

	for _, item := range cases {
		score := heredityScore(item)
		fmt.Printf("case=%s heredity_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
