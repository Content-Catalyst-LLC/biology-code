// Safe physiological condition scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent regulatory-condition scoring.

struct PhysiologicalScenario {
    name: &'static str,
    feedback_capacity: f64,
    effector_capacity: f64,
    signal_integrity: f64,
    stress_load: f64,
    environmental_pressure: f64,
    recovery_support: f64,
}

fn condition_score(s: &PhysiologicalScenario) -> f64 {
    0.22 * s.feedback_capacity
        + 0.20 * s.effector_capacity
        + 0.20 * s.signal_integrity
        + 0.18 * s.recovery_support
        - 0.12 * s.stress_load
        - 0.12 * s.environmental_pressure
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.60 {
        "relatively-buffered"
    } else if score >= 0.42 {
        "stressed"
    } else {
        "high-risk"
    }
}

fn main() {
    let scenarios = vec![
        PhysiologicalScenario { name: "baseline", feedback_capacity: 0.76, effector_capacity: 0.74, signal_integrity: 0.78, stress_load: 0.25, environmental_pressure: 0.25, recovery_support: 0.72 },
        PhysiologicalScenario { name: "high_heat_stress", feedback_capacity: 0.70, effector_capacity: 0.68, signal_integrity: 0.72, stress_load: 0.55, environmental_pressure: 0.60, recovery_support: 0.60 },
        PhysiologicalScenario { name: "dehydration_pressure", feedback_capacity: 0.66, effector_capacity: 0.62, signal_integrity: 0.70, stress_load: 0.50, environmental_pressure: 0.58, recovery_support: 0.55 },
        PhysiologicalScenario { name: "weak_effector_capacity", feedback_capacity: 0.72, effector_capacity: 0.45, signal_integrity: 0.74, stress_load: 0.35, environmental_pressure: 0.40, recovery_support: 0.58 },
        PhysiologicalScenario { name: "recovery_supported", feedback_capacity: 0.82, effector_capacity: 0.80, signal_integrity: 0.84, stress_load: 0.20, environmental_pressure: 0.18, recovery_support: 0.82 },
    ];

    for scenario in scenarios {
        let score = condition_score(&scenario);
        println!(
            "scenario={} physiological_condition_score={:.3} condition_class={}",
            scenario.name,
            score,
            condition_class(score)
        );
    }
}
