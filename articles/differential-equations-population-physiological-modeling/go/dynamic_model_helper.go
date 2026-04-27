// Dynamic biological model helper in Go.

package main

import (
	"fmt"
	"math"
)

func logisticFinal(n0 float64, r float64, k float64, dt float64, tEnd float64) float64 {
	steps := int(math.Floor(tEnd/dt)) + 1
	n := n0

	for i := 1; i < steps; i++ {
		dn := r * n * (1.0 - n/k)
		n = math.Max(n+dn*dt, 0.0)
	}

	return n
}

func homeostasisFinal(x0 float64, setPoint float64, k float64, dt float64, tEnd float64) float64 {
	steps := int(math.Floor(tEnd/dt)) + 1
	x := x0

	for i := 1; i < steps; i++ {
		dx := -k * (x - setPoint)
		x += dx * dt
	}

	return x
}

func pkFinal(c0 float64, eliminationRate float64, dt float64, tEnd float64) float64 {
	steps := int(math.Floor(tEnd/dt)) + 1
	c := c0

	for i := 1; i < steps; i++ {
		dc := -eliminationRate * c
		c = math.Max(c+dc*dt, 0.0)
	}

	return c
}

func main() {
	fmt.Printf("logistic_final=%.5f\n", logisticFinal(100.0, 0.30, 2000.0, 0.05, 40.0))
	fmt.Printf("homeostasis_final=%.5f\n", homeostasisFinal(180.0, 100.0, 0.18, 0.05, 30.0))
	fmt.Printf("pk_final=%.5f\n", pkFinal(20.0, 0.12, 0.05, 48.0))
}
