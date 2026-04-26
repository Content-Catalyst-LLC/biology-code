// Biome and habitat indicator scoring in Go.
//
// This portable example demonstrates a simple weighted spatial priority
// workflow without external dependencies.

package main

import "fmt"

type HabitatSite struct {
	Name                string
	PrecipitationScaled float64
	SoilQuality         float64
	Connectivity        float64
	Disturbance         float64
	LandUsePressure     float64
}

func spatialPriority(site HabitatSite) float64 {
	return 0.25*site.PrecipitationScaled +
		0.25*site.SoilQuality +
		0.25*site.Connectivity -
		0.15*site.Disturbance -
		0.10*site.LandUsePressure
}

func priorityClass(score float64) string {
	if score >= 0.55 {
		return "high"
	}
	if score >= 0.35 {
		return "medium"
	}
	return "low"
}

func main() {
	sites := []HabitatSite{
		{"S1", 0.773, 0.72, 0.80, 0.20, 0.25},
		{"S2", 0.827, 0.81, 0.74, 0.24, 0.30},
		{"S3", 0.709, 0.60, 0.55, 0.45, 0.48},
		{"S4", 0.564, 0.52, 0.40, 0.61, 0.60},
		{"S5", 0.900, 0.88, 0.89, 0.18, 0.18},
	}

	for _, site := range sites {
		score := spatialPriority(site)
		fmt.Printf("site=%s spatial_priority=%.3f priority_class=%s\n", site.Name, score, priorityClass(score))
	}
}
