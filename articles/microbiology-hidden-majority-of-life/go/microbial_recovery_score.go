// Microbial recovery scoring in Go.
//
// This portable example demonstrates a microbial condition score using
// functional richness, nitrification, denitrification, pathogen signal,
// and organic overload.

package main

import "fmt"

type MicrobialSite struct {
	Name                   string
	FunctionalRichness     float64
	NitrificationPotential float64
	DenitrificationBalance float64
	PathogenSignal         float64
	OrganicOverload        float64
}

func conditionIndex(site MicrobialSite) float64 {
	return 0.30*site.FunctionalRichness +
		0.20*site.NitrificationPotential +
		0.20*site.DenitrificationBalance +
		0.15*(1-site.PathogenSignal) +
		0.15*(1-site.OrganicOverload)
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
	sites := []MicrobialSite{
		{"reference_wetland", 0.82, 0.74, 0.71, 0.10, 0.18},
		{"restored_marsh", 0.67, 0.58, 0.60, 0.16, 0.25},
		{"eutrophic_pond", 0.39, 0.33, 0.29, 0.31, 0.77},
		{"agricultural_drainage", 0.45, 0.49, 0.43, 0.27, 0.61},
	}

	for _, site := range sites {
		score := conditionIndex(site)
		fmt.Printf("site=%s condition_index=%.3f condition_class=%s\n", site.Name, score, conditionClass(score))
	}
}
