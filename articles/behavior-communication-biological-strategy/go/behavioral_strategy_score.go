// Behavioral strategy scoring in Go.
//
// This portable example demonstrates utility scoring for behavioral options.

package main

import "fmt"

type BehavioralOption struct {
	Name          string
	Benefit       float64
	EnergeticCost float64
	PredationRisk float64
}

func utility(option BehavioralOption, predationWeight float64) float64 {
	return option.Benefit - 0.8*option.EnergeticCost - predationWeight*option.PredationRisk
}

func strategyClass(score float64) string {
	if score >= 5.0 {
		return "favored"
	}
	if score >= 2.0 {
		return "context-dependent"
	}
	return "disfavored"
}

func main() {
	options := []BehavioralOption{
		{"safe_foraging", 8.0, 2.0, 1.0},
		{"risky_foraging", 14.0, 5.0, 6.0},
		{"territorial_display", 10.0, 4.0, 3.0},
		{"mate_search", 12.0, 6.0, 5.0},
	}

	for _, option := range options {
		score := utility(option, 1.2)
		fmt.Printf("option=%s utility=%.3f strategy_class=%s\n", option.Name, score, strategyClass(score))
	}
}
