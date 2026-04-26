// Conservation priority scoring in Go.
//
// This portable example demonstrates a simple weighted conservation scoring
// workflow without external dependencies.

package main

import (
	"fmt"
	"sort"
)

type ConservationUnit struct {
	Name              string
	ExtinctionRisk    float64
	Endemism          float64
	HabitatLoss       float64
	Fragmentation     float64
	RecoveryPotential float64
	CostIndex         float64
	PriorityScore     float64
}

func scoreUnit(unit ConservationUnit) float64 {
	return 0.30*unit.ExtinctionRisk +
		0.20*unit.Endemism +
		0.20*unit.HabitatLoss +
		0.15*unit.Fragmentation +
		0.10*unit.RecoveryPotential -
		0.05*unit.CostIndex
}

func main() {
	units := []ConservationUnit{
		{"A", 0.92, 0.80, 0.75, 0.88, 0.45, 0.60, 0.0},
		{"B", 0.65, 0.30, 0.90, 0.70, 0.80, 0.45, 0.0},
		{"C", 0.40, 0.25, 0.35, 0.40, 0.70, 0.30, 0.0},
		{"D", 0.85, 0.95, 0.60, 0.92, 0.35, 0.75, 0.0},
		{"E", 0.55, 0.50, 0.70, 0.60, 0.65, 0.50, 0.0},
	}

	for i := range units {
		units[i].PriorityScore = scoreUnit(units[i])
	}

	sort.Slice(units, func(i, j int) bool {
		return units[i].PriorityScore > units[j].PriorityScore
	})

	for _, unit := range units {
		fmt.Printf("unit=%s priority_score=%.3f\n", unit.Name, unit.PriorityScore)
	}
}
