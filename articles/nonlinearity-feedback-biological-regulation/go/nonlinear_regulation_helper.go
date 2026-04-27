// Nonlinear biological regulation helper in Go.

package main

import (
	"fmt"
	"math"
)

func saturatingResponse(signal float64, vmax float64, kHalf float64) float64 {
	return vmax * signal / (kHalf + signal)
}

func hillResponse(signal float64, kHalf float64, n float64) float64 {
	return math.Pow(signal, n) / (math.Pow(kHalf, n) + math.Pow(signal, n))
}

func negativeFeedbackFinal(x0 float64, setPoint float64, k float64, dt float64, tEnd float64) float64 {
	steps := int(math.Floor(tEnd/dt)) + 1
	x := x0

	for i := 1; i < steps; i++ {
		dx := -k * (x - setPoint)
		x += dx * dt
	}

	return x
}

func positiveFeedbackFinal(x0 float64, alpha float64, beta float64, kHalf float64, n float64, dt float64, tEnd float64) float64 {
	steps := int(math.Floor(tEnd/dt)) + 1
	x := x0

	for i := 1; i < steps; i++ {
		production := alpha * math.Pow(x, n) / (math.Pow(kHalf, n) + math.Pow(x, n))
		loss := beta * x
		dx := production - loss
		x = math.Max(x+dx*dt, 0.0)
	}

	return x
}

func main() {
	fmt.Printf("saturating_at_20=%.5f\n", saturatingResponse(20.0, 1.0, 20.0))
	fmt.Printf("hill_at_60_n4=%.5f\n", hillResponse(60.0, 40.0, 4.0))
	fmt.Printf("negative_feedback_final=%.5f\n", negativeFeedbackFinal(180.0, 100.0, 0.18, 0.05, 30.0))
	fmt.Printf("positive_feedback_final=%.5f\n", positiveFeedbackFinal(2.0, 3.0, 0.8, 1.5, 4.0, 0.01, 80.0))
}
