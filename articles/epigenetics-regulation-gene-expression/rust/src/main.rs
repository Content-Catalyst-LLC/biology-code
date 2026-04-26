// Safe epigenetic condition scoring utility in Rust.

struct EpigeneticCase {
    name: &'static str,
    expression_stability: f64,
    accessibility_signal: f64,
    methylation_quality: f64,
    state_memory: f64,
    environmental_responsiveness: f64,
    batch_risk: f64,
}

fn condition_score(case: &EpigeneticCase) -> f64 {
    0.18 * case.expression_stability
        + 0.18 * case.accessibility_signal
        + 0.16 * case.methylation_quality
        + 0.16 * case.state_memory
        + 0.16 * case.environmental_responsiveness
        + 0.16 * (1.0 - case.batch_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "strong_regulatory_signal"
    } else if score >= 0.50 {
        "moderate_regulatory_signal"
    } else {
        "weak_or_high_uncertainty_signal"
    }
}

fn main() {
    let cases = vec![
        EpigeneticCase { name: "reference_cell_system", expression_stability: 0.72, accessibility_signal: 0.76, methylation_quality: 0.70, state_memory: 0.74, environmental_responsiveness: 0.62, batch_risk: 0.20 },
        EpigeneticCase { name: "stressed_plant_tissue", expression_stability: 0.58, accessibility_signal: 0.68, methylation_quality: 0.61, state_memory: 0.52, environmental_responsiveness: 0.86, batch_risk: 0.28 },
        EpigeneticCase { name: "tumor_like_dysregulation", expression_stability: 0.31, accessibility_signal: 0.82, methylation_quality: 0.77, state_memory: 0.34, environmental_responsiveness: 0.66, batch_risk: 0.36 },
        EpigeneticCase { name: "microbial_stress_response", expression_stability: 0.49, accessibility_signal: 0.43, methylation_quality: 0.22, state_memory: 0.41, environmental_responsiveness: 0.88, batch_risk: 0.32 },
    ];

    for case in cases {
        let score = condition_score(&case);
        println!(
            "case={} epigenetic_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
