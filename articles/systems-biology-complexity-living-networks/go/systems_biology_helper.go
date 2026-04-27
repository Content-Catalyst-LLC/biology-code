// Systems biology helper in Go.

package main

import (
	"fmt"
	"math"
)

func simulateFeedback(x0 float64, y0 float64, productionX float64, productionY float64, degradationX float64, degradationY float64, hillN float64, dt float64, steps int) (float64, float64) {
	x := x0
	y := y0

	for step := 0; step < steps; step++ {
		dx := productionX/(1.0+math.Pow(y, hillN)) - degradationX*x
		dy := productionY*x - degradationY*y

		x = x + dt*dx
		y = y + dt*dy

		if x < 0 {
			x = 0
		}
		if y < 0 {
			y = 0
		}
	}

	return x, y
}

func main() {
	x, y := simulateFeedback(0.20, 0.10, 1.20, 0.80, 0.40, 0.30, 2.0, 0.10, 80)

	fmt.Printf("final_x=%.5f\n", x)
	fmt.Printf("final_y=%.5f\n", y)
}
