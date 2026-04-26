// Safe living-order condition scoring utility in Rust.

struct LivingOrderCase {
    name: &'static str,
    homeostatic_regulation: f64,
    metabolic_throughput: f64,
    structural_integration: f64,
    developmental_coordination: f64,
    information_continuity: f64,
    ecological_relation: f64,
    stress_penalty: f64,
}

fn living_order_score(case: &LivingOrderCase) -> f64 {
    0.17 * case.homeostatic_regulation
        + 0.16 * case.metabolic_throughput
        + 0.15 * case.structural_integration
        + 0.13 * case.developmental_coordination
        + 0.15 * case.information_continuity
        + 0.14 * case.ecological_relation
        + 0.10 * (1.0 - case.stress_penalty)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.72 {
        "strong_living_order"
    } else if score >= 0.52 {
        "moderate_living_order"
    } else {
        "constrained_or_high_uncertainty_living_order"
    }
}

fn main() {
    let cases = vec![
        LivingOrderCase { name: "reference_living_system", homeostatic_regulation: 0.86, metabolic_throughput: 0.84, structural_integration: 0.82, developmental_coordination: 0.78, information_continuity: 0.88, ecological_relation: 0.80, stress_penalty: 0.18 },
        LivingOrderCase { name: "metabolic_stress_state", homeostatic_regulation: 0.68, metabolic_throughput: 0.38, structural_integration: 0.70, developmental_coordination: 0.66, information_continuity: 0.80, ecological_relation: 0.72, stress_penalty: 0.58 },
        LivingOrderCase { name: "regulatory_failure_state", homeostatic_regulation: 0.34, metabolic_throughput: 0.66, structural_integration: 0.70, developmental_coordination: 0.62, information_continuity: 0.78, ecological_relation: 0.68, stress_penalty: 0.64 },
        LivingOrderCase { name: "developmental_disruption_state", homeostatic_regulation: 0.72, metabolic_throughput: 0.70, structural_integration: 0.66, developmental_coordination: 0.36, information_continuity: 0.76, ecological_relation: 0.68, stress_penalty: 0.60 },
        LivingOrderCase { name: "ecosystem_fragmentation_state", homeostatic_regulation: 0.70, metabolic_throughput: 0.72, structural_integration: 0.64, developmental_coordination: 0.66, information_continuity: 0.74, ecological_relation: 0.34, stress_penalty: 0.70 },
        LivingOrderCase { name: "recovery_state", homeostatic_regulation: 0.78, metabolic_throughput: 0.76, structural_integration: 0.74, developmental_coordination: 0.72, information_continuity: 0.80, ecological_relation: 0.76, stress_penalty: 0.32 },
    ];

    for case in cases {
        let score = living_order_score(&case);
        println!(
            "case={} living_order_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
