// Genomic condition scoring in Go.

package main

import "fmt"

type GenomicCase struct {
	Name                     string
	AssemblyQuality          float64
	AnnotationDepth          float64
	VariantQuality           float64
	ExpressionSignal         float64
	PopulationRepresentation float64
	ProvenanceQuality        float64
	BiasRisk                 float64
}

func genomicScore(item GenomicCase) float64 {
	return 0.16*item.AssemblyQuality +
		0.16*item.AnnotationDepth +
		0.16*item.VariantQuality +
		0.14*item.ExpressionSignal +
		0.14*item.PopulationRepresentation +
		0.14*item.ProvenanceQuality +
		0.10*(1-item.BiasRisk)
}

func conditionClass(score float64) string {
	if score >= 0.70 {
		return "strong_genomic_evidence_system"
	}
	if score >= 0.50 {
		return "moderate_genomic_evidence_system"
	}
	return "limited_or_high_uncertainty_system"
}

func main() {
	cases := []GenomicCase{
		{"reference_genome_project", 0.84, 0.78, 0.72, 0.66, 0.62, 0.80, 0.22},
		{"conservation_panel", 0.68, 0.61, 0.76, 0.40, 0.82, 0.74, 0.30},
		{"metagenomic_survey", 0.55, 0.58, 0.42, 0.36, 0.70, 0.64, 0.41},
		{"clinical_variant_screen", 0.72, 0.83, 0.88, 0.50, 0.58, 0.79, 0.27},
	}

	for _, item := range cases {
		score := genomicScore(item)
		fmt.Printf("case=%s genomic_condition_score=%.3f condition_class=%s\n", item.Name, score, conditionClass(score))
	}
}
