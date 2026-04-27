// Safe command-line evolutionary scenario ranking utility.

#[derive(Debug)]
struct MismatchScenario {
    trait_system: &'static str,
    current_exposure: f64,
    adapted_reference: f64,
    evidence_confidence: f64,
}

fn weighted_mismatch_score(item: &MismatchScenario) -> f64 {
    (item.current_exposure - item.adapted_reference).abs() * item.evidence_confidence
}

fn main() {
    let scenarios = vec![
        MismatchScenario { trait_system: "energy_storage", current_exposure: 0.90, adapted_reference: 0.45, evidence_confidence: 0.70 },
        MismatchScenario { trait_system: "circadian_regulation", current_exposure: 0.82, adapted_reference: 0.35, evidence_confidence: 0.65 },
        MismatchScenario { trait_system: "immune_calibration", current_exposure: 0.25, adapted_reference: 0.70, evidence_confidence: 0.55 },
    ];

    for scenario in &scenarios {
        println!(
            "{} weighted_mismatch_score={:.5}",
            scenario.trait_system,
            weighted_mismatch_score(scenario)
        );
    }
}
