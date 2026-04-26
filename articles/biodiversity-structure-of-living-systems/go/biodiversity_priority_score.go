// Biodiversity priority scoring in Go.
//
// This portable example demonstrates a simple priority score based on
// effective diversity, richness, fragmentation pressure, and restoration potential.

package main

import "fmt"

type Site struct {
	Name                  string
	HillQ1                float64
	Richness              float64
	FragmentationPressure float64
	RestorationPotential  float64
}

func priorityScore(site Site, maxHillQ1 float64, maxRichness float64) float64 {
	return 0.40*(site.HillQ1/maxHillQ1) +
		0.20*(site.Richness/maxRichness) +
		0.25*site.FragmentationPressure +
		0.15*site.RestorationPotential
}

func priorityClass(score float64) string {
	if score >= 0.65 {
		return "higher"
	}
	if score >= 0.45 {
		return "medium"
	}
	return "lower"
}

func main() {
	sites := []Site{
		{"site_A", 3.40, 4, 0.30, 0.62},
		{"site_B", 3.52, 4, 0.55, 0.74},
		{"site_C", 3.69, 4, 0.70, 0.68},
		{"site_D", 3.43, 5, 0.40, 0.80},
	}

	maxHillQ1 := 3.69
	maxRichness := 5.0

	for _, site := range sites {
		score := priorityScore(site, maxHillQ1, maxRichness)
		fmt.Printf("site=%s priority_score=%.3f priority_class=%s\n", site.Name, score, priorityClass(score))
	}
}
