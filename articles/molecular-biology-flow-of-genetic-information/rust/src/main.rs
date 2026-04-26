// Safe molecular information-flow scoring utility in Rust.

struct MolecularFlowCase {
    name: &'static str,
    replication_fidelity: f64,
    transcription_signal: f64,
    rna_processing: f64,
    translation_support: f64,
    repair_capacity: f64,
    regulatory_context: f64,
    expression_noise_risk: f64,
}

fn molecular_flow_score(case: &MolecularFlowCase) -> f64 {
    0.16 * case.replication_fidelity
        + 0.15 * case.transcription_signal
        + 0.14 * case.rna_processing
        + 0.14 * case.translation_support
        + 0.16 * case.repair_capacity
        + 0.15 * case.regulatory_context
        + 0.10 * (1.0 - case.expression_noise_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.72 {
        "strong_molecular_information_flow"
    } else if score >= 0.52 {
        "moderate_molecular_information_flow"
    } else {
        "constrained_or_high_uncertainty_information_flow"
    }
}

fn main() {
    let cases = vec![
        MolecularFlowCase { name: "reference_cell_state", replication_fidelity: 0.86, transcription_signal: 0.74, rna_processing: 0.78, translation_support: 0.80, repair_capacity: 0.82, regulatory_context: 0.76, expression_noise_risk: 0.18 },
        MolecularFlowCase { name: "stress_response_state", replication_fidelity: 0.70, transcription_signal: 0.90, rna_processing: 0.66, translation_support: 0.68, repair_capacity: 0.64, regulatory_context: 0.84, expression_noise_risk: 0.36 },
        MolecularFlowCase { name: "repair_deficient_state", replication_fidelity: 0.42, transcription_signal: 0.58, rna_processing: 0.54, translation_support: 0.60, repair_capacity: 0.28, regulatory_context: 0.52, expression_noise_risk: 0.72 },
        MolecularFlowCase { name: "high_expression_program", replication_fidelity: 0.74, transcription_signal: 0.92, rna_processing: 0.72, translation_support: 0.84, repair_capacity: 0.66, regulatory_context: 0.80, expression_noise_risk: 0.28 },
        MolecularFlowCase { name: "microbial_adaptation_state", replication_fidelity: 0.68, transcription_signal: 0.78, rna_processing: 0.62, translation_support: 0.70, repair_capacity: 0.58, regulatory_context: 0.74, expression_noise_risk: 0.40 },
    ];

    for case in cases {
        let score = molecular_flow_score(&case);
        println!(
            "case={} molecular_flow_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
