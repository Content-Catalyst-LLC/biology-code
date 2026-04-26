// Safe evolutionary-scale scoring utility in Rust.

struct EvolutionaryScaleCase {
    name: &'static str,
    population_variation: f64,
    lineage_distinctiveness: f64,
    fossil_record_strength: f64,
    phylogenetic_resolution: f64,
    extinction_pressure: f64,
    adaptive_capacity: f64,
}

fn scale_score(case: &EvolutionaryScaleCase) -> f64 {
    0.18 * case.population_variation
        + 0.18 * case.lineage_distinctiveness
        + 0.16 * case.fossil_record_strength
        + 0.16 * case.phylogenetic_resolution
        + 0.16 * (1.0 - case.extinction_pressure)
        + 0.16 * case.adaptive_capacity
}

fn interpretive_class(score: f64) -> &'static str {
    if score < 0.50 {
        "limited"
    } else if score < 0.70 {
        "moderate"
    } else {
        "strong"
    }
}

fn main() {
    let cases = vec![
        EvolutionaryScaleCase { name: "reference_clade", population_variation: 0.72, lineage_distinctiveness: 0.66, fossil_record_strength: 0.80, phylogenetic_resolution: 0.78, extinction_pressure: 0.22, adaptive_capacity: 0.70 },
        EvolutionaryScaleCase { name: "fragmented_population_complex", population_variation: 0.48, lineage_distinctiveness: 0.74, fossil_record_strength: 0.42, phylogenetic_resolution: 0.60, extinction_pressure: 0.66, adaptive_capacity: 0.38 },
        EvolutionaryScaleCase { name: "well_sampled_fossil_group", population_variation: 0.51, lineage_distinctiveness: 0.62, fossil_record_strength: 0.91, phylogenetic_resolution: 0.70, extinction_pressure: 0.35, adaptive_capacity: 0.54 },
        EvolutionaryScaleCase { name: "rapidly_evolving_pathogen", population_variation: 0.88, lineage_distinctiveness: 0.41, fossil_record_strength: 0.20, phylogenetic_resolution: 0.82, extinction_pressure: 0.30, adaptive_capacity: 0.86 },
    ];

    for case in cases {
        let score = scale_score(&case);
        println!(
            "case={} evolutionary_scale_score={:.3} interpretive_class={}",
            case.name,
            score,
            interpretive_class(score)
        );
    }
}
