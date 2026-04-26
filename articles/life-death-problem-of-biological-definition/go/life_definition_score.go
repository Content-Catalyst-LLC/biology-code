// Life-definition scoring in Go.

package main

import "fmt"

type BorderlineCase struct {
	Name                 string
	Organization         float64
	Metabolism           float64
	Autonomy             float64
	Heredity             float64
	Responsiveness       float64
	EvolutionaryCapacity float64
}

func heuristicLifeScore(item BorderlineCase) float64 {
	return 0.18*item.Organization +
		0.18*item.Metabolism +
		0.16*item.Autonomy +
		0.18*item.Heredity +
		0.12*item.Responsiveness +
		0.18*item.EvolutionaryCapacity
}

func category(score float64) string {
	if score >= 0.72 {
		return "strongly_life_like_under_this_matrix"
	}
	if score >= 0.45 {
		return "borderline_or_context_dependent"
	}
	return "weakly_life_like_under_this_matrix"
}

func main() {
	cases := []BorderlineCase{
		{"bacterium", 0.95, 0.90, 0.88, 0.90, 0.85, 0.90},
		{"virus", 0.55, 0.05, 0.10, 0.82, 0.25, 0.88},
		{"dormant_seed", 0.80, 0.20, 0.45, 0.86, 0.40, 0.80},
		{"sterile_mule", 0.95, 0.88, 0.92, 0.80, 0.90, 0.20},
		{"crystal", 0.35, 0.00, 0.00, 0.00, 0.05, 0.00},
	}

	for _, item := range cases {
		score := heuristicLifeScore(item)
		fmt.Printf("case=%s heuristic_life_score=%.3f category=%s\n", item.Name, score, category(score))
	}
}
