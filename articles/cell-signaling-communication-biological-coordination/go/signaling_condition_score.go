// Signaling condition scoring in Go.

package main

import "fmt"

type SignalingCase struct {
	Name                    string
	ReceptorDetection       float64
	TransductionIntegrity   float64
	SecondMessengerCapacity float64
	FeedbackControl         float64
	ResponseSpecificity     float64
	ContextIntegration      float64
	NoiseRisk               float64
}

func signalingScore(item SignalingCase) float64 {
	return 0.16*item.ReceptorDetection +
		0.16*item.TransductionIntegrity +
		0.14*item.SecondMessengerCapacity +
		0.15*item.FeedbackControl +
		0.14*item.ResponseSpecificity +
		0.15*item.ContextIntegration +
		0.10*(1-item.NoiseRisk)
}

func conditionClass(score float64) string {
	if score >= 0.72 {
		return "strong_signaling_coordination"
	}
	if score >= 0.52 {
		return "moderate_signaling_coordination"
	}
	return "constrained_or_high_uncertainty_signaling"
}

func main() {
	cases := []SignalingCase{
		{"reference_cell_state", 0.84, 0.80, 0.78, 0.74, 0.76, 0.72, 0.20},
		{"feedback_deficient_state", 0.72, 0.68, 0.70, 0.32, 0.48, 0.52, 0.64},
		{"immune_activation_state", 0.88, 0.82, 0.86, 0.70, 0.80, 0.78, 0.28},
		{"microbial_quorum_state", 0.76, 0.70, 0.62, 0.58, 0.66, 0.74, 0.34},
		{"plant_stress_state", 0.80, 0.76, 0.68, 0.64, 0.72, 0.84, 0.30},
	}

	for _, item := range cases {
		score := signalingScore(item)
		fmt.Printf("case=%s signaling_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
