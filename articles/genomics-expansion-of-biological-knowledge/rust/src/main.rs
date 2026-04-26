// Safe genomic condition scoring utility in Rust.

struct GenomicCase {
    name: &'static str,
    assembly_quality: f64,
    annotation_depth: f64,
    variant_quality: f64,
    expression_signal: f64,
    population_representation: f64,
    provenance_quality: f64,
    bias_risk: f64,
}

fn genomic_score(case: &GenomicCase) -> f64 {
    0.16 * case.assembly_quality
        + 0.16 * case.annotation_depth
        + 0.16 * case.variant_quality
        + 0.14 * case.expression_signal
        + 0.14 * case.population_representation
        + 0.14 * case.provenance_quality
        + 0.10 * (1.0 - case.bias_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "strong_genomic_evidence_system"
    } else if score >= 0.50 {
        "moderate_genomic_evidence_system"
    } else {
        "limited_or_high_uncertainty_system"
    }
}

fn main() {
    let cases = vec![
        GenomicCase { name: "reference_genome_project", assembly_quality: 0.84, annotation_depth: 0.78, variant_quality: 0.72, expression_signal: 0.66, population_representation: 0.62, provenance_quality: 0.80, bias_risk: 0.22 },
        GenomicCase { name: "conservation_panel", assembly_quality: 0.68, annotation_depth: 0.61, variant_quality: 0.76, expression_signal: 0.40, population_representation: 0.82, provenance_quality: 0.74, bias_risk: 0.30 },
        GenomicCase { name: "metagenomic_survey", assembly_quality: 0.55, annotation_depth: 0.58, variant_quality: 0.42, expression_signal: 0.36, population_representation: 0.70, provenance_quality: 0.64, bias_risk: 0.41 },
        GenomicCase { name: "clinical_variant_screen", assembly_quality: 0.72, annotation_depth: 0.83, variant_quality: 0.88, expression_signal: 0.50, population_representation: 0.58, provenance_quality: 0.79, bias_risk: 0.27 },
    ];

    for case in cases {
        let score = genomic_score(&case);
        println!(
            "case={} genomic_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
