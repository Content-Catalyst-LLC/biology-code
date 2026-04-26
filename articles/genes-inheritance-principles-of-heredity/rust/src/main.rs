// Safe heredity condition scoring utility in Rust.

struct HeredityCase {
    name: &'static str,
    standing_variation: f64,
    inheritance_clarity: f64,
    recombination_information: f64,
    population_size: f64,
    genotype_quality: f64,
    environmental_context: f64,
    inbreeding_risk: f64,
}

fn heredity_score(case: &HeredityCase) -> f64 {
    0.18 * case.standing_variation
        + 0.14 * case.inheritance_clarity
        + 0.12 * case.recombination_information
        + 0.15 * case.population_size
        + 0.15 * case.genotype_quality
        + 0.14 * case.environmental_context
        + 0.12 * (1.0 - case.inbreeding_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "strong_hereditary_resilience"
    } else if score >= 0.50 {
        "moderate_hereditary_resilience"
    } else {
        "constrained_or_high_risk_hereditary_system"
    }
}

fn main() {
    let cases = vec![
        HeredityCase { name: "reference_population", standing_variation: 0.76, inheritance_clarity: 0.78, recombination_information: 0.64, population_size: 0.72, genotype_quality: 0.81, environmental_context: 0.70, inbreeding_risk: 0.18 },
        HeredityCase { name: "bottlenecked_population", standing_variation: 0.32, inheritance_clarity: 0.66, recombination_information: 0.40, population_size: 0.28, genotype_quality: 0.70, environmental_context: 0.58, inbreeding_risk: 0.72 },
        HeredityCase { name: "crop_breeding_panel", standing_variation: 0.82, inheritance_clarity: 0.74, recombination_information: 0.70, population_size: 0.68, genotype_quality: 0.76, environmental_context: 0.62, inbreeding_risk: 0.22 },
        HeredityCase { name: "restoration_seed_source", standing_variation: 0.58, inheritance_clarity: 0.60, recombination_information: 0.44, population_size: 0.52, genotype_quality: 0.66, environmental_context: 0.80, inbreeding_risk: 0.36 },
    ];

    for case in cases {
        let score = heredity_score(&case);
        println!(
            "case={} heredity_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
