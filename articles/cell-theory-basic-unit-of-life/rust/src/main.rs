// Safe cell-condition scoring utility in Rust.

struct CellCondition {
    name: &'static str,
    membrane_integrity: f64,
    metabolic_activity: f64,
    proliferation_capacity: f64,
    genomic_stability: f64,
    organelle_function: f64,
    stress_penalty: f64,
}

fn cell_condition_score(item: &CellCondition) -> f64 {
    0.18 * item.membrane_integrity
        + 0.22 * item.metabolic_activity
        + 0.18 * item.proliferation_capacity
        + 0.17 * item.genomic_stability
        + 0.15 * item.organelle_function
        + 0.10 * (1.0 - item.stress_penalty)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.75 {
        "strong_cell_condition"
    } else if score >= 0.50 {
        "moderate_cell_condition"
    } else {
        "constrained_cell_condition"
    }
}

fn main() {
    let cases = vec![
        CellCondition { name: "control", membrane_integrity: 0.92, metabolic_activity: 0.88, proliferation_capacity: 0.84, genomic_stability: 0.90, organelle_function: 0.86, stress_penalty: 0.12 },
        CellCondition { name: "nutrient_limited", membrane_integrity: 0.78, metabolic_activity: 0.55, proliferation_capacity: 0.48, genomic_stability: 0.82, organelle_function: 0.70, stress_penalty: 0.42 },
        CellCondition { name: "hypoxic", membrane_integrity: 0.70, metabolic_activity: 0.46, proliferation_capacity: 0.42, genomic_stability: 0.76, organelle_function: 0.52, stress_penalty: 0.55 },
        CellCondition { name: "drug_treated", membrane_integrity: 0.62, metabolic_activity: 0.40, proliferation_capacity: 0.30, genomic_stability: 0.68, organelle_function: 0.48, stress_penalty: 0.68 },
        CellCondition { name: "membrane_stress", membrane_integrity: 0.38, metabolic_activity: 0.54, proliferation_capacity: 0.44, genomic_stability: 0.74, organelle_function: 0.60, stress_penalty: 0.64 },
        CellCondition { name: "mitochondrial_stress", membrane_integrity: 0.74, metabolic_activity: 0.36, proliferation_capacity: 0.40, genomic_stability: 0.72, organelle_function: 0.32, stress_penalty: 0.70 },
    ];

    for item in cases {
        let score = cell_condition_score(&item);
        println!(
            "condition={} cell_condition_score={:.3} condition_class={}",
            item.name,
            score,
            condition_class(score)
        );
    }
}
