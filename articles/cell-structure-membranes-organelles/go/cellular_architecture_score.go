// Cellular architecture condition scoring in Go.

package main

import "fmt"

type CellArchitectureCase struct {
	Name                      string
	MembraneIntegrity         float64
	TransportCapacity         float64
	OrganelleSpecialization   float64
	TraffickingCoordination    float64
	EnergyCompartmentFunction float64
	TurnoverCapacity          float64
	StressPenalty             float64
}

func cellularArchitectureScore(item CellArchitectureCase) float64 {
	return 0.17*item.MembraneIntegrity +
		0.15*item.TransportCapacity +
		0.14*item.OrganelleSpecialization +
		0.15*item.TraffickingCoordination +
		0.15*item.EnergyCompartmentFunction +
		0.14*item.TurnoverCapacity +
		0.10*(1-item.StressPenalty)
}

func conditionClass(score float64) string {
	if score >= 0.72 {
		return "strong_cellular_architecture"
	}
	if score >= 0.52 {
		return "moderate_cellular_architecture"
	}
	return "constrained_or_high_uncertainty_architecture"
}

func main() {
	cases := []CellArchitectureCase{
		{"reference_cell_state", 0.86, 0.82, 0.80, 0.78, 0.82, 0.76, 0.18},
		{"membrane_stress_state", 0.46, 0.52, 0.72, 0.60, 0.66, 0.64, 0.58},
		{"mitochondrial_dysfunction_state", 0.76, 0.70, 0.68, 0.62, 0.34, 0.58, 0.64},
		{"trafficking_defect_state", 0.74, 0.66, 0.70, 0.32, 0.62, 0.50, 0.52},
		{"plant_vacuolar_stress_state", 0.70, 0.76, 0.78, 0.68, 0.72, 0.82, 0.34},
		{"marine_osmotic_stress_state", 0.58, 0.48, 0.70, 0.62, 0.64, 0.60, 0.66},
	}

	for _, item := range cases {
		score := cellularArchitectureScore(item)
		fmt.Printf("case=%s cellular_architecture_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
