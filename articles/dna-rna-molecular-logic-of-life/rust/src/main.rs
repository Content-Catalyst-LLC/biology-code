// Safe molecular condition scoring utility in Rust.

struct MolecularCase {
    name: &'static str,
    replication_fidelity: f64,
    transcription_signal: f64,
    rna_stability: f64,
    translation_support: f64,
    repair_capacity: f64,
    regulatory_context: f64,
    damage_risk: f64,
}

fn molecular_score(case: &MolecularCase) -> f64 {
    0.16 * case.replication_fidelity
        + 0.16 * case.transcription_signal
        + 0.14 * case.rna_stability
        + 0.14 * case.translation_support
        + 0.16 * case.repair_capacity
        + 0.14 * case.regulatory_context
        + 0.10 * (1.0 - case.damage_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "strong_molecular_continuity_and_response"
    } else if score >= 0.50 {
        "moderate_molecular_continuity_and_response"
    } else {
        "molecularly_constrained_or_high_uncertainty"
    }
}

fn main() {
    let cases = vec![
        MolecularCase { name: "reference_cell_state", replication_fidelity: 0.86, transcription_signal: 0.72, rna_stability: 0.70, translation_support: 0.78, repair_capacity: 0.82, regulatory_context: 0.74, damage_risk: 0.18 },
        MolecularCase { name: "stress_response_state", replication_fidelity: 0.70, transcription_signal: 0.88, rna_stability: 0.46, translation_support: 0.66, repair_capacity: 0.64, regulatory_context: 0.82, damage_risk: 0.38 },
        MolecularCase { name: "damage_repair_deficient", replication_fidelity: 0.42, transcription_signal: 0.58, rna_stability: 0.54, translation_support: 0.61, repair_capacity: 0.28, regulatory_context: 0.50, damage_risk: 0.77 },
        MolecularCase { name: "high_expression_program", replication_fidelity: 0.74, transcription_signal: 0.92, rna_stability: 0.69, translation_support: 0.84, repair_capacity: 0.66, regulatory_context: 0.79, damage_risk: 0.29 },
    ];

    for case in cases {
        let score = molecular_score(&case);
        println!(
            "case={} molecular_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
