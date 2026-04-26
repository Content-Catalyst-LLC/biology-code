// Safe signaling condition scoring utility in Rust.

struct SignalingCase {
    name: &'static str,
    receptor_detection: f64,
    transduction_integrity: f64,
    second_messenger_capacity: f64,
    feedback_control: f64,
    response_specificity: f64,
    context_integration: f64,
    noise_risk: f64,
}

fn signaling_score(case: &SignalingCase) -> f64 {
    0.16 * case.receptor_detection
        + 0.16 * case.transduction_integrity
        + 0.14 * case.second_messenger_capacity
        + 0.15 * case.feedback_control
        + 0.14 * case.response_specificity
        + 0.15 * case.context_integration
        + 0.10 * (1.0 - case.noise_risk)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.72 {
        "strong_signaling_coordination"
    } else if score >= 0.52 {
        "moderate_signaling_coordination"
    } else {
        "constrained_or_high_uncertainty_signaling"
    }
}

fn main() {
    let cases = vec![
        SignalingCase { name: "reference_cell_state", receptor_detection: 0.84, transduction_integrity: 0.80, second_messenger_capacity: 0.78, feedback_control: 0.74, response_specificity: 0.76, context_integration: 0.72, noise_risk: 0.20 },
        SignalingCase { name: "feedback_deficient_state", receptor_detection: 0.72, transduction_integrity: 0.68, second_messenger_capacity: 0.70, feedback_control: 0.32, response_specificity: 0.48, context_integration: 0.52, noise_risk: 0.64 },
        SignalingCase { name: "immune_activation_state", receptor_detection: 0.88, transduction_integrity: 0.82, second_messenger_capacity: 0.86, feedback_control: 0.70, response_specificity: 0.80, context_integration: 0.78, noise_risk: 0.28 },
        SignalingCase { name: "microbial_quorum_state", receptor_detection: 0.76, transduction_integrity: 0.70, second_messenger_capacity: 0.62, feedback_control: 0.58, response_specificity: 0.66, context_integration: 0.74, noise_risk: 0.34 },
        SignalingCase { name: "plant_stress_state", receptor_detection: 0.80, transduction_integrity: 0.76, second_messenger_capacity: 0.68, feedback_control: 0.64, response_specificity: 0.72, context_integration: 0.84, noise_risk: 0.30 },
    ];

    for case in cases {
        let score = signaling_score(&case);
        println!(
            "case={} signaling_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
