// Biological modeling helper in Go.

package main

import "fmt"

func logisticGrowth(initial float64, growthRate float64, carryingCapacity float64, dt float64, steps int) float64 {
	population := initial

	for step := 0; step < steps; step++ {
		growth := growthRate * population * (1.0 - population/carryingCapacity)
		population = population + dt*growth
		if population < 0 {
			population = 0
		}
	}

	return population
}

func twoCompartment(initialA float64, initialB float64, kAB float64, kBA float64, kClear float64, dt float64, steps int) (float64, float64, float64) {
	amountA := initialA
	amountB := initialB

	for step := 0; step < steps; step++ {
		flowAB := kAB * amountA
		flowBA := kBA * amountB
		clearance := kClear * amountA

		nextA := amountA + dt*(-flowAB+flowBA-clearance)
		nextB := amountB + dt*(flowAB-flowBA)

		if nextA < 0 {
			nextA = 0
		}
		if nextB < 0 {
			nextB = 0
		}

		amountA = nextA
		amountB = nextB
	}

	return amountA, amountB, amountA + amountB
}

func main() {
	finalPopulation := logisticGrowth(25, 0.35, 1000, 0.1, 200)
	a, b, total := twoCompartment(100, 0, 0.18, 0.07, 0.03, 0.1, 150)

	fmt.Printf("final_population=%.5f\n", finalPopulation)
	fmt.Printf("final_compartment_a=%.5f\n", a)
	fmt.Printf("final_compartment_b=%.5f\n", b)
	fmt.Printf("final_total_amount=%.5f\n", total)
}
