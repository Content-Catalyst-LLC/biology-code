// Biological network helper in Go.

package main

import "fmt"

func degree(adjacency [][]float64) []int {
	degrees := make([]int, len(adjacency))

	for i, row := range adjacency {
		count := 0
		for _, value := range row {
			if value > 0 {
				count++
			}
		}
		degrees[i] = count
	}

	return degrees
}

func density(adjacency [][]float64) float64 {
	n := len(adjacency)
	edges := 0.0

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if adjacency[i][j] > 0 {
				edges++
			}
		}
	}

	possible := float64(n*(n-1)) / 2.0
	return edges / possible
}

func diffuse(adjacency [][]float64, initial []float64, alpha float64, decay float64, steps int) []float64 {
	n := len(initial)
	state := make([]float64, n)
	copy(state, initial)

	for step := 0; step < steps; step++ {
		next := make([]float64, n)

		for i := 0; i < n; i++ {
			next[i] = state[i] - decay*state[i]

			for j := 0; j < n; j++ {
				next[i] += alpha * adjacency[i][j] * state[j]
			}

			if next[i] < 0 {
				next[i] = 0
			}
		}

		state = next
	}

	return state
}

func main() {
	adjacency := [][]float64{
		{0, 1, 0.8, 0, 0, 0},
		{1, 0, 0.7, 1.2, 0, 0},
		{0.8, 0.7, 0, 0, 0.9, 0},
		{0, 1.2, 0, 0, 1.1, 0.6},
		{0, 0, 0.9, 1.1, 0, 0.5},
		{0, 0, 0, 0.6, 0.5, 0},
	}

	degrees := degree(adjacency)
	totalDegree := 0
	maxDegree := 0

	for _, d := range degrees {
		totalDegree += d
		if d > maxDegree {
			maxDegree = d
		}
	}

	finalState := diffuse(adjacency, []float64{1, 0, 0, 0, 0, 0}, 0.08, 0.04, 20)

	fmt.Printf("density=%.5f\n", density(adjacency))
	fmt.Printf("mean_degree=%.5f\n", float64(totalDegree)/float64(len(degrees)))
	fmt.Printf("max_degree=%d\n", maxDegree)
	fmt.Printf("final_state=%v\n", finalState)
}
