// Reproductive continuity scoring in Go.
//
// This portable example demonstrates a simple continuity score using
// fecundity, survival, maturation, buffering, and environmental stress.

package main

import "fmt"

type LifeHistoryUnit struct {
	Name                 string
	Fecundity            float64
	JuvenileSurvival     float64
	AdultSurvival        float64
	MaturationRate       float64
	DormancyOrBuffering  float64
	EnvironmentalStress  float64
}

func continuityScore(unit LifeHistoryUnit, maxFecundity float64) float64 {
	return 0.20*(unit.Fecundity/maxFecundity) +
		0.20*unit.JuvenileSurvival +
		0.25*unit.AdultSurvival +
		0.15*unit.MaturationRate +
		0.10*unit.DormancyOrBuffering -
		0.20*unit.EnvironmentalStress
}

func continuityClass(score float64) string {
	if score >= 0.60 {
		return "relatively-buffered"
	}
	if score >= 0.45 {
		return "vulnerable"
	}
	return "high-risk"
}

func main() {
	units := []LifeHistoryUnit{
		{"A", 2.4, 0.35, 0.82, 0.50, 0.40, 0.25},
		{"B", 1.9, 0.55, 0.88, 0.40, 0.52, 0.20},
		{"C", 3.1, 0.22, 0.60, 0.65, 0.30, 0.50},
		{"D", 1.3, 0.68, 0.92, 0.30, 0.60, 0.18},
		{"E", 2.2, 0.40, 0.76, 0.48, 0.45, 0.32},
	}

	maxFecundity := 3.1

	for _, unit := range units {
		score := continuityScore(unit, maxFecundity)
		fmt.Printf("unit=%s continuity_score=%.3f continuity_class=%s\n", unit.Name, score, continuityClass(score))
	}
}
