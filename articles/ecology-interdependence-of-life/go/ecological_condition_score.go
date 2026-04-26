// Ecological condition scoring in Go.
//
// This portable example demonstrates a condition score using diversity,
// turnover, productivity, nutrient retention, disturbance, and connectivity.

package main

import "fmt"

type Site struct {
	Name                string
	Shannon             float64
	MeanTurnover        float64
	Productivity        float64
	NutrientRetention   float64
	DisturbancePressure float64
	Connectivity        float64
}

func ecologicalCondition(site Site, maxShannon float64) float64 {
	return 0.20*(site.Shannon/maxShannon) +
		0.20*site.Productivity +
		0.20*site.NutrientRetention +
		0.15*site.Connectivity -
		0.15*site.MeanTurnover -
		0.20*site.DisturbancePressure
}

func conditionClass(score float64) string {
	if score >= 0.55 {
		return "relatively-buffered"
	}
	if score >= 0.35 {
		return "stressed"
	}
	return "high-risk"
}

func main() {
	sites := []Site{
		{"site_A", 1.41, 0.37, 0.84, 0.80, 0.18, 0.86},
		{"site_B", 1.39, 0.34, 0.78, 0.74, 0.27, 0.73},
		{"site_C", 1.39, 0.42, 0.62, 0.58, 0.61, 0.41},
		{"site_D", 1.40, 0.39, 0.71, 0.64, 0.44, 0.56},
		{"site_E", 1.53, 0.32, 0.75, 0.70, 0.30, 0.68},
	}

	maxShannon := 1.53

	for _, site := range sites {
		score := ecologicalCondition(site, maxShannon)
		fmt.Printf("site=%s ecological_condition=%.3f condition_class=%s\n", site.Name, score, conditionClass(score))
	}
}
