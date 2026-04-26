// Assay validation helper in Go.

package main

import "fmt"

type Assay struct {
	Name          string
	TP            float64
	FN            float64
	TN            float64
	FP            float64
}

func main() {
	assays := []Assay{
		{"biosensor_A", 84, 16, 91, 9},
		{"biosensor_B", 76, 24, 95, 5},
		{"sequence_test_A", 92, 8, 88, 12},
	}

	for _, a := range assays {
		sensitivity := a.TP / (a.TP + a.FN)
		specificity := a.TN / (a.TN + a.FP)
		ppv := a.TP / (a.TP + a.FP)
		npv := a.TN / (a.TN + a.FN)
		accuracy := (a.TP + a.TN) / (a.TP + a.FN + a.TN + a.FP)

		fmt.Printf("assay=%s sensitivity=%.3f specificity=%.3f ppv=%.3f npv=%.3f accuracy=%.3f\n",
			a.Name, sensitivity, specificity, ppv, npv, accuracy)
	}
}
