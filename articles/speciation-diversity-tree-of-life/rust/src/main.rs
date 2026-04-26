// Safe speciation condition scoring utility in Rust.

struct SpeciationCase {
    name: &'static str,
    allele_divergence: f64,
    reproductive_isolation: f64,
    ecological_difference: f64,
    phylogenetic_resolution: f64,
    gene_flow_risk: f64,
    lineage_distinctiveness: f64,
}

fn condition_score(case: &SpeciationCase) -> f64 {
    0.20 * case.allele_divergence
        + 0.20 * case.reproductive_isolation
        + 0.18 * case.ecological_difference
        + 0.16 * case.phylogenetic_resolution
        + 0.14 * (1.0 - case.gene_flow_risk)
        + 0.12 * case.lineage_distinctiveness
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "strong_lineage_separation"
    } else if score >= 0.50 {
        "partial_or_emerging_separation"
    } else {
        "weak_or_unresolved_separation"
    }
}

fn main() {
    let cases = vec![
        SpeciationCase { name: "reference_pair", allele_divergence: 0.68, reproductive_isolation: 0.72, ecological_difference: 0.66, phylogenetic_resolution: 0.78, gene_flow_risk: 0.20, lineage_distinctiveness: 0.74 },
        SpeciationCase { name: "hybrid_zone", allele_divergence: 0.46, reproductive_isolation: 0.38, ecological_difference: 0.55, phylogenetic_resolution: 0.63, gene_flow_risk: 0.72, lineage_distinctiveness: 0.50 },
        SpeciationCase { name: "island_radiation", allele_divergence: 0.74, reproductive_isolation: 0.69, ecological_difference: 0.82, phylogenetic_resolution: 0.70, gene_flow_risk: 0.18, lineage_distinctiveness: 0.80 },
        SpeciationCase { name: "microbial_complex", allele_divergence: 0.51, reproductive_isolation: 0.30, ecological_difference: 0.61, phylogenetic_resolution: 0.52, gene_flow_risk: 0.45, lineage_distinctiveness: 0.58 },
    ];

    for case in cases {
        let score = condition_score(&case);
        println!(
            "case={} speciation_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
