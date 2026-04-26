// Safe selection condition scoring utility in Rust.

struct SelectionCase {
    name: &'static str,
    standing_variation: f64,
    selection_strength: f64,
    environmental_match: f64,
    demographic_stability: f64,
    gene_flow_support: f64,
    constraint_risk: f64,
}

fn condition_score(case: &SelectionCase) -> f64 {
    0.18 * case.standing_variation
        + 0.18 * case.selection_strength
        + 0.18 * case.environmental_match
        + 0.16 * case.demographic_stability
        + 0.14 * case.gene_flow_support
        + 0.16 * (1.0 - case.constraint_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "high_adaptive_potential"
    } else if score >= 0.50 {
        "moderate_adaptive_potential"
    } else {
        "constrained_or_at_risk"
    }
}

fn main() {
    let cases = vec![
        SelectionCase { name: "reference_population", standing_variation: 0.72, selection_strength: 0.58, environmental_match: 0.70, demographic_stability: 0.74, gene_flow_support: 0.62, constraint_risk: 0.22 },
        SelectionCase { name: "fragmented_adaptation_lag", standing_variation: 0.38, selection_strength: 0.76, environmental_match: 0.34, demographic_stability: 0.40, gene_flow_support: 0.20, constraint_risk: 0.71 },
        SelectionCase { name: "pathogen_resistance_system", standing_variation: 0.84, selection_strength: 0.88, environmental_match: 0.79, demographic_stability: 0.68, gene_flow_support: 0.55, constraint_risk: 0.25 },
        SelectionCase { name: "restoration_target_site", standing_variation: 0.61, selection_strength: 0.52, environmental_match: 0.57, demographic_stability: 0.60, gene_flow_support: 0.48, constraint_risk: 0.36 },
    ];

    for case in cases {
        let score = condition_score(&case);
        println!(
            "case={} selection_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
