// Population persistence scoring in Go.
//
// This portable example demonstrates a simple persistence score using growth,
// carrying capacity, harvest, catastrophe probability, and connectivity.

package main

import "fmt"

type Scenario struct {
	Name                   string
	GrowthRate             float64
	CarryingCapacity       float64
	Harvest                float64
	CatastropheProbability float64
	Connectivity           float64
}

func persistenceScore(s Scenario) float64 {
	return 0.35*s.GrowthRate +
		0.25*(s.CarryingCapacity/650.0) +
		0.20*s.Connectivity -
		0.10*(s.Harvest/20.0) -
		0.10*s.CatastropheProbability
}

func riskClass(score float64) string {
	if score >= 0.45 {
		return "higher-persistence"
	}
	if score >= 0.25 {
		return "moderate-persistence"
	}
	return "higher-risk"
}

func main() {
	scenarios := []Scenario{
		{"baseline", 0.18, 500.0, 5.0, 0.05, 0.70},
		{"higher_harvest", 0.18, 500.0, 15.0, 0.05, 0.70},
		{"lower_capacity", 0.15, 300.0, 5.0, 0.06, 0.55},
		{"restoration_gain", 0.20, 650.0, 3.0, 0.03, 0.85},
	}

	for _, scenario := range scenarios {
		score := persistenceScore(scenario)
		fmt.Printf("scenario=%s persistence_score=%.3f risk_class=%s\n", scenario.Name, score, riskClass(score))
	}
}
