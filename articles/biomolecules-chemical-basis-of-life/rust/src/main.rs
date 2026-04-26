// Safe biomolecular condition scoring utility in Rust.

struct BiomolecularCase {
    name: &'static str,
    carbohydrate_support: f64,
    lipid_boundary_function: f64,
    protein_function: f64,
    nucleic_acid_integrity: f64,
    metabolite_balance: f64,
    cofactor_availability: f64,
    stress_penalty: f64,
}

fn biomolecular_condition_score(case: &BiomolecularCase) -> f64 {
    0.14 * case.carbohydrate_support
        + 0.15 * case.lipid_boundary_function
        + 0.18 * case.protein_function
        + 0.17 * case.nucleic_acid_integrity
        + 0.14 * case.metabolite_balance
        + 0.12 * case.cofactor_availability
        + 0.10 * (1.0 - case.stress_penalty)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.72 {
        "strong_biomolecular_function"
    } else if score >= 0.52 {
        "moderate_biomolecular_function"
    } else {
        "constrained_or_high_uncertainty_biomolecular_state"
    }
}

fn main() {
    let cases = vec![
        BiomolecularCase { name: "reference_cell_state", carbohydrate_support: 0.84, lipid_boundary_function: 0.82, protein_function: 0.86, nucleic_acid_integrity: 0.88, metabolite_balance: 0.80, cofactor_availability: 0.78, stress_penalty: 0.18 },
        BiomolecularCase { name: "energy_storage_deficit", carbohydrate_support: 0.42, lipid_boundary_function: 0.76, protein_function: 0.74, nucleic_acid_integrity: 0.82, metabolite_balance: 0.58, cofactor_availability: 0.70, stress_penalty: 0.48 },
        BiomolecularCase { name: "membrane_disruption_state", carbohydrate_support: 0.72, lipid_boundary_function: 0.38, protein_function: 0.68, nucleic_acid_integrity: 0.80, metabolite_balance: 0.62, cofactor_availability: 0.66, stress_penalty: 0.60 },
        BiomolecularCase { name: "protein_misfolding_state", carbohydrate_support: 0.76, lipid_boundary_function: 0.72, protein_function: 0.34, nucleic_acid_integrity: 0.82, metabolite_balance: 0.60, cofactor_availability: 0.58, stress_penalty: 0.66 },
        BiomolecularCase { name: "genomic_damage_state", carbohydrate_support: 0.78, lipid_boundary_function: 0.74, protein_function: 0.70, nucleic_acid_integrity: 0.36, metabolite_balance: 0.64, cofactor_availability: 0.62, stress_penalty: 0.70 },
        BiomolecularCase { name: "metabolic_cofactor_limited_state", carbohydrate_support: 0.70, lipid_boundary_function: 0.72, protein_function: 0.62, nucleic_acid_integrity: 0.78, metabolite_balance: 0.42, cofactor_availability: 0.30, stress_penalty: 0.58 },
    ];

    for case in cases {
        let score = biomolecular_condition_score(&case);
        println!(
            "case={} biomolecular_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
