// Coevolution and symbiosis condition scoring in Go.

package main

import "fmt"

type SymbiosisSite struct {
	Name                    string
	PartnerPresence         float64
	InteractionStability    float64
	EnvironmentalStress     float64
	CheatingPressure        float64
	TransmissionReliability float64
	FunctionalRedundancy    float64
}

func conditionScore(site SymbiosisSite) float64 {
	return 0.22*site.PartnerPresence +
		0.22*site.InteractionStability +
		0.18*site.TransmissionReliability +
		0.16*site.FunctionalRedundancy +
		0.12*(1-site.EnvironmentalStress) +
		0.10*(1-site.CheatingPressure)
}

func conditionClass(score float64) string {
	if score < 0.50 {
		return "high-concern"
	}
	if score < 0.70 {
		return "moderate"
	}
	return "strong"
}

func main() {
	sites := []SymbiosisSite{
		{"reference_reef", 0.88, 0.78, 0.20, 0.12, 0.82, 0.66},
		{"warming_stressed_reef", 0.62, 0.45, 0.74, 0.18, 0.56, 0.38},
		{"restored_prairie", 0.70, 0.63, 0.35, 0.20, 0.68, 0.55},
		{"degraded_soil_site", 0.41, 0.34, 0.62, 0.31, 0.42, 0.29},
	}

	for _, site := range sites {
		score := conditionScore(site)
		fmt.Printf("site=%s symbiosis_condition_score=%.3f condition_class=%s\n", site.Name, score, conditionClass(score))
	}
}
