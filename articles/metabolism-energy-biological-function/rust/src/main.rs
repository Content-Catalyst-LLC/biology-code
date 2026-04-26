// Safe metabolic condition scoring utility in Rust.

struct MetabolicCase {
    name: &'static str,
    substrate_availability: f64,
    energy_conversion: f64,
    redox_balance: f64,
    growth_capacity: f64,
    maintenance_resilience: f64,
    pathway_integration: f64,
    stress_penalty: f64,
}

fn metabolic_condition_score(case: &MetabolicCase) -> f64 {
    0.16 * case.substrate_availability
        + 0.17 * case.energy_conversion
        + 0.15 * case.redox_balance
        + 0.14 * case.growth_capacity
        + 0.14 * case.maintenance_resilience
        + 0.14 * case.pathway_integration
        + 0.10 * (1.0 - case.stress_penalty)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.72 {
        "strong_metabolic_function"
    } else if score >= 0.52 {
        "moderate_metabolic_function"
    } else {
        "constrained_or_high_uncertainty_metabolism"
    }
}

fn main() {
    let cases = vec![
        MetabolicCase { name: "reference_cell_state", substrate_availability: 0.84, energy_conversion: 0.82, redox_balance: 0.78, growth_capacity: 0.80, maintenance_resilience: 0.74, pathway_integration: 0.76, stress_penalty: 0.18 },
        MetabolicCase { name: "nutrient_limited_state", substrate_availability: 0.38, energy_conversion: 0.70, redox_balance: 0.66, growth_capacity: 0.42, maintenance_resilience: 0.62, pathway_integration: 0.58, stress_penalty: 0.40 },
        MetabolicCase { name: "hypoxic_state", substrate_availability: 0.72, energy_conversion: 0.40, redox_balance: 0.36, growth_capacity: 0.46, maintenance_resilience: 0.58, pathway_integration: 0.52, stress_penalty: 0.62 },
        MetabolicCase { name: "microbial_soil_system", substrate_availability: 0.78, energy_conversion: 0.74, redox_balance: 0.70, growth_capacity: 0.72, maintenance_resilience: 0.80, pathway_integration: 0.84, stress_penalty: 0.26 },
        MetabolicCase { name: "plant_stress_state", substrate_availability: 0.62, energy_conversion: 0.68, redox_balance: 0.64, growth_capacity: 0.58, maintenance_resilience: 0.76, pathway_integration: 0.72, stress_penalty: 0.34 },
    ];

    for case in cases {
        let score = metabolic_condition_score(&case);
        println!(
            "case={} metabolic_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
