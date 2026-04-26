// Plant condition scoring in Go.

package main

import "fmt"

type PlantSite struct {
	Name                 string
	CanopyCondition      float64
	WaterAvailability    float64
	NutrientStatus       float64
	SoilFunction         float64
	DiseasePressure      float64
	DroughtStress        float64
	RegenerationSupport  float64
}

func conditionScore(site PlantSite) float64 {
	return 0.20*site.CanopyCondition +
		0.18*site.WaterAvailability +
		0.16*site.NutrientStatus +
		0.16*site.SoilFunction +
		0.15*site.RegenerationSupport +
		0.08*(1-site.DiseasePressure) +
		0.07*(1-site.DroughtStress)
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
	sites := []PlantSite{
		{"reference_forest", 0.86, 0.78, 0.74, 0.82, 0.10, 0.18, 0.80},
		{"restoration_plot", 0.62, 0.56, 0.59, 0.54, 0.17, 0.35, 0.61},
		{"drought_stressed_woodland", 0.48, 0.32, 0.50, 0.46, 0.22, 0.68, 0.39},
		{"riparian_repair_site", 0.70, 0.74, 0.64, 0.68, 0.14, 0.28, 0.72},
	}

	for _, site := range sites {
		score := conditionScore(site)
		fmt.Printf("site=%s plant_condition_score=%.3f condition_class=%s\n", site.Name, score, conditionClass(score))
	}
}
