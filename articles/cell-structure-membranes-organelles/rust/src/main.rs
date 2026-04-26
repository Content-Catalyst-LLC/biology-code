// Safe cellular architecture condition scoring utility in Rust.

struct CellArchitectureCase {
    name: &'static str,
    membrane_integrity: f64,
    transport_capacity: f64,
    organelle_specialization: f64,
    trafficking_coordination: f64,
    energy_compartment_function: f64,
    turnover_capacity: f64,
    stress_penalty: f64,
}

fn cellular_architecture_score(case: &CellArchitectureCase) -> f64 {
    0.17 * case.membrane_integrity
        + 0.15 * case.transport_capacity
        + 0.14 * case.organelle_specialization
        + 0.15 * case.trafficking_coordination
        + 0.15 * case.energy_compartment_function
        + 0.14 * case.turnover_capacity
        + 0.10 * (1.0 - case.stress_penalty)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.72 {
        "strong_cellular_architecture"
    } else if score >= 0.52 {
        "moderate_cellular_architecture"
    } else {
        "constrained_or_high_uncertainty_architecture"
    }
}

fn main() {
    let cases = vec![
        CellArchitectureCase { name: "reference_cell_state", membrane_integrity: 0.86, transport_capacity: 0.82, organelle_specialization: 0.80, trafficking_coordination: 0.78, energy_compartment_function: 0.82, turnover_capacity: 0.76, stress_penalty: 0.18 },
        CellArchitectureCase { name: "membrane_stress_state", membrane_integrity: 0.46, transport_capacity: 0.52, organelle_specialization: 0.72, trafficking_coordination: 0.60, energy_compartment_function: 0.66, turnover_capacity: 0.64, stress_penalty: 0.58 },
        CellArchitectureCase { name: "mitochondrial_dysfunction_state", membrane_integrity: 0.76, transport_capacity: 0.70, organelle_specialization: 0.68, trafficking_coordination: 0.62, energy_compartment_function: 0.34, turnover_capacity: 0.58, stress_penalty: 0.64 },
        CellArchitectureCase { name: "trafficking_defect_state", membrane_integrity: 0.74, transport_capacity: 0.66, organelle_specialization: 0.70, trafficking_coordination: 0.32, energy_compartment_function: 0.62, turnover_capacity: 0.50, stress_penalty: 0.52 },
        CellArchitectureCase { name: "plant_vacuolar_stress_state", membrane_integrity: 0.70, transport_capacity: 0.76, organelle_specialization: 0.78, trafficking_coordination: 0.68, energy_compartment_function: 0.72, turnover_capacity: 0.82, stress_penalty: 0.34 },
        CellArchitectureCase { name: "marine_osmotic_stress_state", membrane_integrity: 0.58, transport_capacity: 0.48, organelle_specialization: 0.70, trafficking_coordination: 0.62, energy_compartment_function: 0.64, turnover_capacity: 0.60, stress_penalty: 0.66 },
    ];

    for case in cases {
        let score = cellular_architecture_score(&case);
        println!(
            "case={} cellular_architecture_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
