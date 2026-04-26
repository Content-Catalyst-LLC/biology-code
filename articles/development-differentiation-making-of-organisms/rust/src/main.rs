// Safe developmental condition scoring utility in Rust.

struct DevelopmentalCase {
    name: &'static str,
    growth_coherence: f64,
    differentiation_signal: f64,
    patterning_signal: f64,
    morphogenesis_quality: f64,
    environmental_stability: f64,
    perturbation_risk: f64,
}

fn condition_score(case: &DevelopmentalCase) -> f64 {
    0.18 * case.growth_coherence
        + 0.18 * case.differentiation_signal
        + 0.16 * case.patterning_signal
        + 0.16 * case.morphogenesis_quality
        + 0.16 * case.environmental_stability
        + 0.16 * (1.0 - case.perturbation_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "strong_developmental_coherence"
    } else if score >= 0.50 {
        "moderate_developmental_coherence"
    } else {
        "developmentally_constrained_or_at_risk"
    }
}

fn main() {
    let cases = vec![
        DevelopmentalCase { name: "reference_embryoid_system", growth_coherence: 0.74, differentiation_signal: 0.78, patterning_signal: 0.72, morphogenesis_quality: 0.70, environmental_stability: 0.68, perturbation_risk: 0.20 },
        DevelopmentalCase { name: "stressed_larval_system", growth_coherence: 0.42, differentiation_signal: 0.55, patterning_signal: 0.48, morphogenesis_quality: 0.44, environmental_stability: 0.30, perturbation_risk: 0.72 },
        DevelopmentalCase { name: "restoration_seedling_stage", growth_coherence: 0.61, differentiation_signal: 0.58, patterning_signal: 0.52, morphogenesis_quality: 0.50, environmental_stability: 0.46, perturbation_risk: 0.38 },
        DevelopmentalCase { name: "organoid_screening_model", growth_coherence: 0.68, differentiation_signal: 0.82, patterning_signal: 0.63, morphogenesis_quality: 0.59, environmental_stability: 0.74, perturbation_risk: 0.31 },
    ];

    for case in cases {
        let score = condition_score(&case);
        println!(
            "case={} developmental_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
