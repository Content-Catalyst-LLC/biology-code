// Microscopy image-analysis helper in Go.

package main

import (
	"fmt"
	"math"
)

func gaussianIntensity(x float64, y float64, cx float64, cy float64, sigma float64, amplitude float64) float64 {
	distanceSquared := math.Pow(x-cx, 2) + math.Pow(y-cy, 2)
	return amplitude * math.Exp(-distanceSquared/(2.0*math.Pow(sigma, 2)))
}

func syntheticIntensity(x float64, y float64) float64 {
	return 18.0 +
		gaussianIntensity(x, y, 18.0, 20.0, 4.0, 140.0) +
		gaussianIntensity(x, y, 42.0, 25.0, 5.0, 170.0) +
		gaussianIntensity(x, y, 30.0, 45.0, 4.5, 155.0)
}

func main() {
	threshold := 65.0
	foregroundPixels := 0
	integratedIntensity := 0.0

	for y := 0; y < 64; y++ {
		for x := 0; x < 64; x++ {
			intensity := syntheticIntensity(float64(x), float64(y))
			if intensity >= threshold {
				foregroundPixels++
				integratedIntensity += intensity
			}
		}
	}

	fmt.Printf("foreground_pixels=%d\n", foregroundPixels)
	fmt.Printf("integrated_intensity=%.5f\n", integratedIntensity)
}
