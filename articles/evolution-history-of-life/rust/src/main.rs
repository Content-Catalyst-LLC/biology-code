// Safe evolutionary condition scoring utility in Rust.

struct EvolutionCase {
    name: &'static str,
    standing_variation: f64,
    phylogenetic_signal: f64,
    fossil_record_strength: f64,
    environmental_change: f64,
    extinction_pressure: f64,
    adaptive_capacity: f64,
}

fn condition_score(case: &EvolutionCase) -> f64 {
    0.17 * case.standing_variation
        + 0.17 * case.phylogenetic_signal
        + 0.16 * case.fossil_record_strength
        + 0.16 * (1.0 - case.environmental_change)
        + 0.17 * (1.0 - case.extinction_pressure)
        + 0.17 * case.adaptive_capacity
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "strong_evolutionary_continuity"
    } else if score >= 0.50 {
        "moderate_evolutionary_continuity"
    } else {
        "constrained_or_at_risk"
    }
}

fn main() {
    let cases = vec![
        EvolutionCase { name: "reference_lineage", standing_variation: 0.72, phylogenetic_signal: 0.78, fossil_record_strength: 0.70, environmental_change: 0.34, extinction_pressure: 0.22, adaptive_capacity: 0.68 },
        EvolutionCase { name: "fragmented_relict_group", standing_variation: 0.38, phylogenetic_signal: 0.74, fossil_record_strength: 0.82, environmental_change: 0.71, extinction_pressure: 0.76, adaptive_capacity: 0.31 },
        EvolutionCase { name: "rapidly_evolving_pathogen", standing_variation: 0.88, phylogenetic_signal: 0.52, fossil_record_strength: 0.20, environmental_change: 0.63, extinction_pressure: 0.35, adaptive_capacity: 0.86 },
        EvolutionCase { name: "well_sampled_fossil_clade", standing_variation: 0.55, phylogenetic_signal: 0.66, fossil_record_strength: 0.94, environmental_change: 0.42, extinction_pressure: 0.30, adaptive_capacity: 0.52 },
    ];

    for case in cases {
        let score = condition_score(&case);
        println!(
            "case={} evolutionary_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
