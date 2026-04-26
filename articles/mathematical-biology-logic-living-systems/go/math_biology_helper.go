// Mathematical biology helper in Go.

package main

import (
	"fmt"
	"math"
)

func logisticGrowth(t float64, n0 float64, r float64, k float64) float64 {
	return k / (1.0 + ((k-n0)/n0)*math.Exp(-r*t))
}

func michaelisMenten(substrate float64, vmax float64, km float64) float64 {
	return vmax * substrate / (km + substrate)
}

func main() {
	fmt.Printf("logistic_final=%.4f\n", logisticGrowth(40.0, 100.0, 0.30, 2000.0))
	fmt.Printf("michaelis_menten_velocity=%.4f\n", michaelisMenten(5.0, 10.0, 2.0))

	beta := 0.35
	gamma := 0.10
	dt := 0.05
	timeEnd := 120.0

	s := 0.99
	i := 0.01
	r := 0.0

	peakI := i
	timeToPeak := 0.0

	steps := int(math.Floor(timeEnd / dt))

	for step := 0; step < steps; step++ {
		time := float64(step) * dt

		if i > peakI {
			peakI = i
			timeToPeak = time
		}

		ds := -beta * s * i
		di := beta*s*i - gamma*i
		dr := gamma * i

		s = math.Max(s+ds*dt, 0)
		i = math.Max(i+di*dt, 0)
		r = math.Max(r+dr*dt, 0)
	}

	fmt.Printf("sir_peak_infected=%.6f\n", peakI)
	fmt.Printf("sir_time_to_peak=%.3f\n", timeToPeak)
	fmt.Printf("sir_final_recovered=%.6f\n", r)
}
