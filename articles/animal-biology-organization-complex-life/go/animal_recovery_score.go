// Animal condition scoring in Go.

package main

import "fmt"

type AnimalSite struct {
	Name                 string
	HabitatQuality       float64
	FoodAvailability     float64
	DiseasePressure      float64
	HeatStress           float64
	ReproductiveSupport  float64
	MovementConnectivity float64
}

func conditionScore(site AnimalSite) float64 {
	return 0.24*site.HabitatQuality +
		0.20*site.FoodAvailability +
		0.18*site.ReproductiveSupport +
		0.18*site.MovementConnectivity +
		0.10*(1-site.DiseasePressure) +
		0.10*(1-site.HeatStress)
}

func conditionClass(score float64) string {
	if score < 0.55 {
		return "high-concern"
	}
	if score < 0.72 {
		return "moderate"
	}
	return "strong"
}

func main() {
	sites := []AnimalSite{
		{"reference_reserve", 0.86, 0.82, 0.08, 0.16, 0.80, 0.78},
		{"fragmented_woodland", 0.52, 0.58, 0.18, 0.34, 0.50, 0.35},
		{"heat_stressed_wetland", 0.61, 0.55, 0.21, 0.62, 0.47, 0.51},
		{"restored_corridor", 0.72, 0.69, 0.13, 0.28, 0.67, 0.76},
	}

	for _, site := range sites {
		score := conditionScore(site)
		fmt.Printf("site=%s animal_condition_score=%.3f condition_class=%s\n", site.Name, score, conditionClass(score))
	}
}
