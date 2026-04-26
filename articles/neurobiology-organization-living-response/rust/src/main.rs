// Safe neural response scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates a transparent neural-condition score.

struct NeuralScenario {
    name: &'static str,
    recovery_rate: f64,
    input_gain: f64,
    noise_pressure: f64,
    stress_load: f64,
    connectivity_integrity: f64,
}

fn condition_score(scenario: &NeuralScenario, max_recovery_rate: f64) -> f64 {
    0.25 * (scenario.recovery_rate / max_recovery_rate)
        + 0.25 * scenario.input_gain
        + 0.25 * scenario.connectivity_integrity
        - 0.15 * scenario.noise_pressure
        - 0.20 * scenario.stress_load
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "relatively-buffered"
    } else if score >= 0.50 {
        "stressed"
    } else {
        "high-risk"
    }
}

fn main() {
    let scenarios = vec![
        NeuralScenario { name: "baseline", recovery_rate: 0.30, input_gain: 1.00, noise_pressure: 0.10, stress_load: 0.20, connectivity_integrity: 0.90 },
        NeuralScenario { name: "high_noise", recovery_rate: 0.28, input_gain: 0.90, noise_pressure: 0.45, stress_load: 0.25, connectivity_integrity: 0.82 },
        NeuralScenario { name: "thermal_stress", recovery_rate: 0.24, input_gain: 0.85, noise_pressure: 0.20, stress_load: 0.55, connectivity_integrity: 0.78 },
        NeuralScenario { name: "toxic_exposure", recovery_rate: 0.20, input_gain: 0.70, noise_pressure: 0.30, stress_load: 0.50, connectivity_integrity: 0.62 },
        NeuralScenario { name: "restoration_recovery", recovery_rate: 0.34, input_gain: 1.05, noise_pressure: 0.08, stress_load: 0.15, connectivity_integrity: 0.95 },
    ];

    let max_recovery_rate = 0.34;

    for scenario in scenarios {
        let score = condition_score(&scenario, max_recovery_rate);
        println!(
            "scenario={} neural_condition_score={:.3} condition_class={}",
            scenario.name,
            score,
            condition_class(score)
        );
    }
}
