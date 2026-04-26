// Safe immune condition scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates a transparent immune-condition score.

struct ImmuneScenario {
    name: &'static str,
    clearance_capacity: f64,
    activation_capacity: f64,
    regulatory_capacity: f64,
    damage_pressure: f64,
    stress_load: f64,
    memory_support: f64,
}

fn immune_condition_score(s: &ImmuneScenario) -> f64 {
    0.22 * s.clearance_capacity
        + 0.18 * s.activation_capacity
        + 0.22 * s.regulatory_capacity
        + 0.18 * s.memory_support
        - 0.15 * s.damage_pressure
        - 0.15 * s.stress_load
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
        ImmuneScenario { name: "baseline", clearance_capacity: 0.75, activation_capacity: 0.70, regulatory_capacity: 0.72, damage_pressure: 0.25, stress_load: 0.25, memory_support: 0.70 },
        ImmuneScenario { name: "high_pathogen_pressure", clearance_capacity: 0.70, activation_capacity: 0.75, regulatory_capacity: 0.65, damage_pressure: 0.45, stress_load: 0.40, memory_support: 0.68 },
        ImmuneScenario { name: "immune_suppression", clearance_capacity: 0.45, activation_capacity: 0.40, regulatory_capacity: 0.70, damage_pressure: 0.30, stress_load: 0.55, memory_support: 0.50 },
        ImmuneScenario { name: "hyperinflammatory", clearance_capacity: 0.78, activation_capacity: 0.90, regulatory_capacity: 0.35, damage_pressure: 0.75, stress_load: 0.50, memory_support: 0.65 },
        ImmuneScenario { name: "recovery_supported", clearance_capacity: 0.82, activation_capacity: 0.74, regulatory_capacity: 0.84, damage_pressure: 0.20, stress_load: 0.18, memory_support: 0.78 },
    ];

    for scenario in scenarios {
        let score = immune_condition_score(&scenario);
        println!(
            "scenario={} immune_condition_score={:.3} condition_class={}",
            scenario.name,
            score,
            condition_class(score)
        );
    }
}
