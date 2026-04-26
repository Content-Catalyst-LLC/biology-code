// Safe novelty condition scoring utility in Rust.

struct NoveltyCase {
    name: &'static str,
    mutation_supply: f64,
    standing_variation: f64,
    recombination_potential: f64,
    regulatory_flexibility: f64,
    developmental_modularity: f64,
    ecological_opportunity: f64,
    constraint_risk: f64,
}

fn novelty_score(case: &NoveltyCase) -> f64 {
    0.15 * case.mutation_supply
        + 0.17 * case.standing_variation
        + 0.14 * case.recombination_potential
        + 0.15 * case.regulatory_flexibility
        + 0.15 * case.developmental_modularity
        + 0.14 * case.ecological_opportunity
        + 0.10 * (1.0 - case.constraint_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "high_novelty_potential"
    } else if score >= 0.50 {
        "moderate_novelty_potential"
    } else {
        "constrained_or_low_novelty_potential"
    }
}

fn main() {
    let cases = vec![
        NoveltyCase { name: "reference_population", mutation_supply: 0.58, standing_variation: 0.74, recombination_potential: 0.66, regulatory_flexibility: 0.62, developmental_modularity: 0.61, ecological_opportunity: 0.55, constraint_risk: 0.22 },
        NoveltyCase { name: "bottlenecked_population", mutation_supply: 0.31, standing_variation: 0.28, recombination_potential: 0.32, regulatory_flexibility: 0.40, developmental_modularity: 0.45, ecological_opportunity: 0.48, constraint_risk: 0.68 },
        NoveltyCase { name: "microbial_stress_system", mutation_supply: 0.88, standing_variation: 0.69, recombination_potential: 0.54, regulatory_flexibility: 0.76, developmental_modularity: 0.52, ecological_opportunity: 0.84, constraint_risk: 0.30 },
        NoveltyCase { name: "crop_breeding_panel", mutation_supply: 0.63, standing_variation: 0.81, recombination_potential: 0.79, regulatory_flexibility: 0.58, developmental_modularity: 0.56, ecological_opportunity: 0.61, constraint_risk: 0.24 },
    ];

    for case in cases {
        let score = novelty_score(&case);
        println!(
            "case={} novelty_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
