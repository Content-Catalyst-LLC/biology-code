// Taxonomic confidence scoring in Rust.

struct Assignment {
    record_id: &'static str,
    candidate_taxon: &'static str,
    sequence_similarity: f64,
    morphological_support: f64,
    geographic_plausibility: f64,
    phylogenetic_support: f64,
    uncertainty_penalty: f64,
}

fn confidence_score(a: &Assignment) -> f64 {
    0.30 * a.sequence_similarity
        + 0.20 * a.morphological_support
        + 0.15 * a.geographic_plausibility
        + 0.25 * a.phylogenetic_support
        - 0.10 * a.uncertainty_penalty
}

fn confidence_class(score: f64) -> &'static str {
    if score >= 0.75 {
        "high_confidence"
    } else if score >= 0.55 {
        "moderate_confidence"
    } else {
        "low_confidence"
    }
}

fn main() {
    let assignments = vec![
        Assignment { record_id: "obs_001", candidate_taxon: "Species_A", sequence_similarity: 0.98, morphological_support: 0.90, geographic_plausibility: 0.88, phylogenetic_support: 0.94, uncertainty_penalty: 0.05 },
        Assignment { record_id: "obs_002", candidate_taxon: "Species_B", sequence_similarity: 0.91, morphological_support: 0.65, geographic_plausibility: 0.82, phylogenetic_support: 0.70, uncertainty_penalty: 0.20 },
        Assignment { record_id: "obs_003", candidate_taxon: "Species_C", sequence_similarity: 0.84, morphological_support: 0.78, geographic_plausibility: 0.55, phylogenetic_support: 0.62, uncertainty_penalty: 0.32 },
        Assignment { record_id: "obs_004", candidate_taxon: "Species_D", sequence_similarity: 0.73, morphological_support: 0.40, geographic_plausibility: 0.30, phylogenetic_support: 0.45, uncertainty_penalty: 0.55 },
    ];

    for a in assignments {
        let score = confidence_score(&a);
        println!(
            "record_id={} candidate_taxon={} score={:.3} class={}",
            a.record_id,
            a.candidate_taxon,
            score,
            confidence_class(score)
        );
    }
}
