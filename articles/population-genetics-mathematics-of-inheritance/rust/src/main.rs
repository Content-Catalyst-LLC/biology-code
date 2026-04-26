// Safe population-genetic condition scoring utility in Rust.

struct PopulationCase {
    name: &'static str,
    heterozygosity: f64,
    allelic_richness: f64,
    gene_flow: f64,
    fragmentation_pressure: f64,
    bottleneck_risk: f64,
    adaptive_capacity: f64,
}

fn condition_score(case: &PopulationCase) -> f64 {
    0.18 * case.heterozygosity
        + 0.18 * case.allelic_richness
        + 0.16 * case.gene_flow
        + 0.16 * (1.0 - case.fragmentation_pressure)
        + 0.16 * (1.0 - case.bottleneck_risk)
        + 0.16 * case.adaptive_capacity
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "strong"
    } else if score >= 0.50 {
        "moderate"
    } else {
        "at_risk"
    }
}

fn main() {
    let cases = vec![
        PopulationCase { name: "reference_metapopulation", heterozygosity: 0.72, allelic_richness: 0.68, gene_flow: 0.66, fragmentation_pressure: 0.22, bottleneck_risk: 0.18, adaptive_capacity: 0.70 },
        PopulationCase { name: "isolated_fragment", heterozygosity: 0.38, allelic_richness: 0.35, gene_flow: 0.22, fragmentation_pressure: 0.78, bottleneck_risk: 0.74, adaptive_capacity: 0.31 },
        PopulationCase { name: "restoration_source_mix", heterozygosity: 0.61, allelic_richness: 0.58, gene_flow: 0.52, fragmentation_pressure: 0.35, bottleneck_risk: 0.30, adaptive_capacity: 0.62 },
        PopulationCase { name: "pathogen_resistance_pool", heterozygosity: 0.82, allelic_richness: 0.74, gene_flow: 0.48, fragmentation_pressure: 0.28, bottleneck_risk: 0.25, adaptive_capacity: 0.86 },
    ];

    for case in cases {
        let score = condition_score(&case);
        println!(
            "case={} population_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
