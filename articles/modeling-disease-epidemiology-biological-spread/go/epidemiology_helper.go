// Epidemiology helper in Go.

package main

import "fmt"

func sirFinal(population float64, initialInfected float64, beta float64, gamma float64, dt float64, steps int) (float64, float64, float64) {
	susceptible := population - initialInfected
	infected := initialInfected
	recovered := 0.0

	for step := 0; step < steps; step++ {
		newInfections := beta * susceptible * infected / population
		newRecoveries := gamma * infected

		susceptible = susceptible - dt*newInfections
		infected = infected + dt*(newInfections-newRecoveries)
		recovered = recovered + dt*newRecoveries

		if susceptible < 0 {
			susceptible = 0
		}
		if infected < 0 {
			infected = 0
		}
		if recovered > population {
			recovered = population
		}
	}

	return susceptible, infected, recovered
}

func main() {
	s, i, r := sirFinal(10000, 10, 0.32, 0.10, 0.25, 240)

	fmt.Printf("sir_final_susceptible=%.5f\n", s)
	fmt.Printf("sir_final_infected=%.5f\n", i)
	fmt.Printf("sir_final_recovered=%.5f\n", r)
}
