// Probability and biological inference helper in Go.

package main

import (
	"fmt"
	"math"
)

func binomialSummary(successes float64, trials float64) (float64, float64, float64, float64) {
	estimate := successes / trials
	se := math.Sqrt(estimate * (1.0 - estimate) / trials)
	lower := math.Max(estimate-1.96*se, 0.0)
	upper := math.Min(estimate+1.96*se, 1.0)
	return estimate, se, lower, upper
}

func betaBinomialUpdate(alphaPrior float64, betaPrior float64, successes float64, trials float64) (float64, float64, float64, float64) {
	failures := trials - successes
	alphaPost := alphaPrior + successes
	betaPost := betaPrior + failures
	total := alphaPost + betaPost
	mean := alphaPost / total
	variance := (alphaPost * betaPost) / (total * total * (total + 1.0))
	return alphaPost, betaPost, mean, math.Sqrt(variance)
}

func binomialLogLikelihood(successes float64, trials float64, p float64) float64 {
	if p <= 0 || p >= 1 {
		return math.Inf(-1)
	}
	failures := trials - successes
	return successes*math.Log(p) + failures*math.Log(1.0-p)
}

func main() {
	estimate, se, lower, upper := binomialSummary(68, 100)
	alphaPost, betaPost, posteriorMean, posteriorSD := betaBinomialUpdate(1, 1, 68, 100)

	bestP := 0.0
	bestLL := math.Inf(-1)

	for i := 10; i <= 90; i++ {
		p := float64(i) / 100.0
		ll := binomialLogLikelihood(68, 100, p)
		if ll > bestLL {
			bestLL = ll
			bestP = p
		}
	}

	fmt.Printf("estimate=%.5f\n", estimate)
	fmt.Printf("standard_error=%.5f\n", se)
	fmt.Printf("ci_lower=%.5f\n", lower)
	fmt.Printf("ci_upper=%.5f\n", upper)
	fmt.Printf("alpha_posterior=%.3f\n", alphaPost)
	fmt.Printf("beta_posterior=%.3f\n", betaPost)
	fmt.Printf("posterior_mean=%.5f\n", posteriorMean)
	fmt.Printf("posterior_sd=%.5f\n", posteriorSD)
	fmt.Printf("best_likelihood_p=%.5f\n", bestP)
	fmt.Printf("best_log_likelihood=%.5f\n", bestLL)
}
