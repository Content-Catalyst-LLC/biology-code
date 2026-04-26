// Nutrient-risk scoring in Go.
//
// This portable example demonstrates a simple nutrient and oxygen stress
// screening workflow without external dependencies.

package main

import "fmt"

type Site struct {
	Name                    string
	NitrogenLoading          float64
	PhosphorusLoading        float64
	OxygenStability          float64
	AssimilationCapacity     float64
	StratificationLimitation float64
}

func nutrientRisk(site Site) float64 {
	return 0.35*site.NitrogenLoading +
		0.30*site.PhosphorusLoading +
		0.20*site.StratificationLimitation -
		0.25*site.AssimilationCapacity -
		0.20*site.OxygenStability
}

func riskClass(score float64) string {
	if score >= 0.35 {
		return "high-risk"
	}
	if score >= 0.15 {
		return "stressed"
	}
	return "relatively-buffered"
}

func main() {
	sites := []Site{
		{"S1", 0.28, 0.22, 0.84, 0.72, 0.20},
		{"S2", 0.46, 0.38, 0.67, 0.58, 0.35},
		{"S3", 0.81, 0.74, 0.39, 0.36, 0.62},
		{"S4", 0.20, 0.18, 0.87, 0.79, 0.15},
		{"S5", 0.63, 0.57, 0.53, 0.49, 0.50},
	}

	for _, site := range sites {
		score := nutrientRisk(site)
		fmt.Printf("site=%s nutrient_risk=%.3f risk_class=%s\n", site.Name, score, riskClass(score))
	}
}
