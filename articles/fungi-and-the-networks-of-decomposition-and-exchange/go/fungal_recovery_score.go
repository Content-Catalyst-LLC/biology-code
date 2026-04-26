// Fungal recovery scoring in Go.
//
// This portable example demonstrates a restoration-priority score using
// mycorrhizal inoculum, saprotroph activity, soil connectivity, pathogen
// pressure, and drought stress.

package main

import "fmt"

type FungalSite struct {
	Name                 string
	MycorrhizalInoculum float64
	SaprotrophActivity  float64
	SoilConnectivity    float64
	PathogenPressure    float64
	DroughtStress       float64
}

func recoveryScore(site FungalSite) float64 {
	return 0.30*site.MycorrhizalInoculum +
		0.25*site.SaprotrophActivity +
		0.20*site.SoilConnectivity +
		0.15*(1-site.PathogenPressure) +
		0.10*(1-site.DroughtStress)
}

func priorityClass(score float64) string {
	if score < 0.55 {
		return "high-intervention"
	}
	if score < 0.70 {
		return "moderate-intervention"
	}
	return "lower-intervention"
}

func main() {
	sites := []FungalSite{
		{"A", 0.82, 0.77, 0.74, 0.12, 0.25},
		{"B", 0.45, 0.58, 0.50, 0.21, 0.42},
		{"C", 0.18, 0.29, 0.35, 0.33, 0.68},
		{"D", 0.61, 0.65, 0.69, 0.19, 0.37},
	}

	for _, site := range sites {
		score := recoveryScore(site)
		fmt.Printf("site=%s recovery_score=%.3f priority_class=%s\n", site.Name, score, priorityClass(score))
	}
}
