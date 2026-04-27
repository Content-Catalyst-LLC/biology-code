// R biology summary helper in Go.

package main

import (
	"fmt"
	"math"
)

func mean(values []float64) float64 {
	total := 0.0
	for _, v := range values {
		total += v
	}
	return total / float64(len(values))
}

func sampleSD(values []float64) float64 {
	m := mean(values)
	sumsq := 0.0
	for _, v := range values {
		sumsq += math.Pow(v-m, 2)
	}
	return math.Sqrt(sumsq / float64(len(values)-1))
}

func shannonDiversity(counts []float64) float64 {
	total := 0.0
	for _, c := range counts {
		if c > 0 {
			total += c
		}
	}

	h := 0.0
	for _, c := range counts {
		if c > 0 {
			p := c / total
			h += -p * math.Log(p)
		}
	}

	return h
}

func log2FoldChange(control []float64, treated []float64, pseudocount float64) float64 {
	return math.Log2((mean(treated) + pseudocount) / (mean(control) + pseudocount))
}

func main() {
	control := []float64{10.2, 10.5, 10.1, 10.4, 10.3, 10.6}
	treated := []float64{12.1, 12.4, 11.9, 12.0, 12.5}
	counts := []float64{18, 7, 3, 0}
	geneControl := []float64{120, 130, 125}
	geneTreated := []float64{300, 310, 290}

	fmt.Printf("control_mean=%.5f\n", mean(control))
	fmt.Printf("treated_mean=%.5f\n", mean(treated))
	fmt.Printf("control_sd=%.5f\n", sampleSD(control))
	fmt.Printf("shannon_diversity=%.5f\n", shannonDiversity(counts))
	fmt.Printf("gene_log2_fold_change=%.5f\n", log2FoldChange(geneControl, geneTreated, 1.0))
}
