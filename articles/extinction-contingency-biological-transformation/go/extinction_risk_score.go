// Extinction condition scoring in Go.

package main

import "fmt"

type ExtinctionSite struct {
	Name                    string
	LineageIrreplaceability float64
	RangeContraction        float64
	HabitatFragmentation    float64
	FunctionalUniqueness    float64
	RecoveryPotential       float64
	MonitoringConfidence    float64
}

func conditionScore(site ExtinctionSite) float64 {
	return 0.22*site.LineageIrreplaceability +
		0.20*site.RangeContraction +
		0.20*site.HabitatFragmentation +
		0.18*site.FunctionalUniqueness +
		0.12*(1-site.RecoveryPotential) +
		0.08*site.MonitoringConfidence
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "critical"
	}
	if score >= 0.50 {
		return "high_concern"
	}
	return "watch"
}

func main() {
	sites := []ExtinctionSite{
		{"reference_refugium", 0.70, 0.22, 0.18, 0.64, 0.76, 0.82},
		{"fragmented_endemism_zone", 0.88, 0.71, 0.76, 0.81, 0.34, 0.61},
		{"degraded_freshwater_basin", 0.76, 0.63, 0.69, 0.72, 0.42, 0.58},
		{"recovering_landscape", 0.54, 0.36, 0.41, 0.50, 0.68, 0.74},
	}

	for _, site := range sites {
		score := conditionScore(site)
		fmt.Printf("site=%s extinction_condition_score=%.3f condition_class=%s\n", site.Name, score, conditionClass(score))
	}
}
