package main

import (
	"fmt"
	"math"
)

type Scenario struct {
	Name        string
	S           float64
	B           float64
	Disturbance float64
}

type Result struct {
	FinalV float64
	FinalM float64
	FinalF float64
	PeakF  float64
}

func simulateRestoration(s float64, bSupport float64, disturbance float64) Result {
	a := 0.8
	b := 0.15
	c := 0.20
	p := 0.10
	q := 0.25
	r := 0.12
	u := 0.08
	v := 0.10
	w := 0.18
	dt := 0.05
	tEnd := 50.0

	vegetation := 10.0
	microbial := 8.0
	function := 6.0
	peakFunction := function

	for time := dt; time <= tEnd+1e-12; time += dt {
		dv := a*s - b*vegetation - c*disturbance
		dm := p*vegetation + q*bSupport - r*microbial
		df := u*vegetation + v*microbial - w*disturbance

		vegetation = math.Max(0.0, vegetation+dv*dt)
		microbial = math.Max(0.0, microbial+dm*dt)
		function = math.Max(0.0, function+df*dt)

		peakFunction = math.Max(peakFunction, function)
	}

	return Result{
		FinalV: vegetation,
		FinalM: microbial,
		FinalF: function,
		PeakF:  peakFunction,
	}
}

func main() {
	scenarios := []Scenario{
		{"low_effort_high_disturbance", 0.7, 0.8, 0.8},
		{"moderate_effort_moderate_disturbance", 1.0, 0.8, 0.5},
		{"high_effort_low_disturbance", 1.4, 0.8, 0.2},
		{"soil_limited_recovery", 1.1, 0.3, 0.4},
	}

	fmt.Println("scenario,final_V,final_M,final_F,peak_F")

	for _, scenario := range scenarios {
		result := simulateRestoration(scenario.S, scenario.B, scenario.Disturbance)
		fmt.Printf("%s,%.6f,%.6f,%.6f,%.6f\n",
			scenario.Name,
			result.FinalV,
			result.FinalM,
			result.FinalF,
			result.PeakF,
		)
	}
}
