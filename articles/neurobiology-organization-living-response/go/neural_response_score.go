// Neural response scoring in Go.
//
// This portable example demonstrates a neural-condition score using recovery,
// input gain, noise pressure, stress load, and connectivity integrity.

package main

import "fmt"

type NeuralScenario struct {
	Name                  string
	RecoveryRate          float64
	InputGain             float64
	NoisePressure         float64
	StressLoad            float64
	ConnectivityIntegrity float64
}

func conditionScore(s NeuralScenario, maxRecoveryRate float64) float64 {
	return 0.25*(s.RecoveryRate/maxRecoveryRate) +
		0.25*s.InputGain +
		0.25*s.ConnectivityIntegrity -
		0.15*s.NoisePressure -
		0.20*s.StressLoad
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "relatively-buffered"
	}
	if score >= 0.50 {
		return "stressed"
	}
	return "high-risk"
}

func main() {
	scenarios := []NeuralScenario{
		{"baseline", 0.30, 1.00, 0.10, 0.20, 0.90},
		{"high_noise", 0.28, 0.90, 0.45, 0.25, 0.82},
		{"thermal_stress", 0.24, 0.85, 0.20, 0.55, 0.78},
		{"toxic_exposure", 0.20, 0.70, 0.30, 0.50, 0.62},
		{"restoration_recovery", 0.34, 1.05, 0.08, 0.15, 0.95},
	}

	maxRecoveryRate := 0.34

	for _, scenario := range scenarios {
		score := conditionScore(scenario, maxRecoveryRate)
		fmt.Printf("scenario=%s neural_condition_score=%.3f condition_class=%s\n", scenario.Name, score, conditionClass(score))
	}
}
