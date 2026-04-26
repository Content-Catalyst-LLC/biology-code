// Taxonomic confidence scoring in Go.

package main

import "fmt"

type Assignment struct {
	RecordID               string
	CandidateTaxon         string
	SequenceSimilarity     float64
	MorphologicalSupport   float64
	GeographicPlausibility float64
	PhylogeneticSupport    float64
	UncertaintyPenalty     float64
}

func confidenceScore(a Assignment) float64 {
	return 0.30*a.SequenceSimilarity +
		0.20*a.MorphologicalSupport +
		0.15*a.GeographicPlausibility +
		0.25*a.PhylogeneticSupport -
		0.10*a.UncertaintyPenalty
}

func confidenceClass(score float64) string {
	if score >= 0.75 {
		return "high_confidence"
	}
	if score >= 0.55 {
		return "moderate_confidence"
	}
	return "low_confidence"
}

func main() {
	assignments := []Assignment{
		{"obs_001", "Species_A", 0.98, 0.90, 0.88, 0.94, 0.05},
		{"obs_002", "Species_B", 0.91, 0.65, 0.82, 0.70, 0.20},
		{"obs_003", "Species_C", 0.84, 0.78, 0.55, 0.62, 0.32},
		{"obs_004", "Species_D", 0.73, 0.40, 0.30, 0.45, 0.55},
	}

	for _, a := range assignments {
		score := confidenceScore(a)
		fmt.Printf("record_id=%s candidate_taxon=%s score=%.3f class=%s\n", a.RecordID, a.CandidateTaxon, score, confidenceClass(score))
	}
}
