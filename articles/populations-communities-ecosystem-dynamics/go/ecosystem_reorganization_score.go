// Ecosystem reorganization risk scoring in Go.
//
// This portable example demonstrates a simple risk score using turnover,
// disturbance, productivity, nutrient retention, and connectivity.

package main

import "fmt"

type Site struct {
	Name                string
	MeanTurnover        float64
	Productivity        float64
	NutrientRetention  float64
	DisturbancePressure float64
	Connectivity       float64
}

func reorganizationRisk(site Site, maxTurnover float64, maxProductivity float64, maxNutrientRetention float64) float64 {
	return 0.20*(site.MeanTurnover/maxTurnover) +
		0.25*site.DisturbancePressure +
		0.20*(1.0-site.Connectivity) -
		0.15*(site.Productivity/maxProductivity) -
		0.20*(site.NutrientRetention/maxNutrientRetention)
}

func riskClass(score float64) string {
	if score >= 0.15 {
		return "higher-reorganization-risk"
	}
	if score >= 0.00 {
		return "moderate-reorganization-risk"
	}
	return "lower-reorganization-risk"
}

func main() {
	sites := []Site{
		{"site_A", 0.42, 0.82, 0.79, 0.20, 0.85},
		{"site_B", 0.38, 0.76, 0.71, 0.28, 0.70},
		{"site_C", 0.51, 0.61, 0.55, 0.60, 0.42},
		{"site_D", 0.47, 0.70, 0.63, 0.45, 0.58},
		{"site_E", 0.40, 0.74, 0.68, 0.33, 0.66},
	}

	maxTurnover := 0.51
	maxProductivity := 0.82
	maxNutrientRetention := 0.79

	for _, site := range sites {
		score := reorganizationRisk(site, maxTurnover, maxProductivity, maxNutrientRetention)
		fmt.Printf("site=%s reorganization_risk=%.3f risk_class=%s\n", site.Name, score, riskClass(score))
	}
}
