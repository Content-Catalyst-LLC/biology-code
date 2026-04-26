// Safe enzyme and biochemical pathway condition scoring utility in Rust.

struct EnzymeCase {
    name: &'static str,
    catalytic_capacity: f64,
    substrate_access: f64,
    regulatory_control: f64,
    cofactor_availability: f64,
    pathway_integration: f64,
    environmental_stability: f64,
    inhibition_risk: f64,
}

fn enzyme_pathway_score(case: &EnzymeCase) -> f64 {
    0.17 * case.catalytic_capacity
        + 0.14 * case.substrate_access
        + 0.15 * case.regulatory_control
        + 0.14 * case.cofactor_availability
        + 0.16 * case.pathway_integration
        + 0.14 * case.environmental_stability
        + 0.10 * (1.0 - case.inhibition_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.72 {
        "strong_enzyme_pathway_function"
    } else if score >= 0.52 {
        "moderate_enzyme_pathway_function"
    } else {
        "constrained_or_high_uncertainty_pathway"
    }
}

fn main() {
    let cases = vec![
        EnzymeCase { name: "reference_pathway", catalytic_capacity: 0.84, substrate_access: 0.78, regulatory_control: 0.76, cofactor_availability: 0.80, pathway_integration: 0.74, environmental_stability: 0.72, inhibition_risk: 0.18 },
        EnzymeCase { name: "inhibited_pathway", catalytic_capacity: 0.52, substrate_access: 0.70, regulatory_control: 0.48, cofactor_availability: 0.68, pathway_integration: 0.58, environmental_stability: 0.62, inhibition_risk: 0.68 },
        EnzymeCase { name: "cofactor_limited_state", catalytic_capacity: 0.62, substrate_access: 0.74, regulatory_control: 0.66, cofactor_availability: 0.32, pathway_integration: 0.54, environmental_stability: 0.58, inhibition_risk: 0.42 },
        EnzymeCase { name: "microbial_soil_pathway", catalytic_capacity: 0.78, substrate_access: 0.82, regulatory_control: 0.70, cofactor_availability: 0.76, pathway_integration: 0.84, environmental_stability: 0.64, inhibition_risk: 0.26 },
        EnzymeCase { name: "thermal_stress_state", catalytic_capacity: 0.50, substrate_access: 0.68, regulatory_control: 0.58, cofactor_availability: 0.60, pathway_integration: 0.52, environmental_stability: 0.34, inhibition_risk: 0.46 },
    ];

    for case in cases {
        let score = enzyme_pathway_score(&case);
        println!(
            "case={} enzyme_pathway_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
