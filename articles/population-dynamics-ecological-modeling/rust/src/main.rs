// Safe population risk scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent persistence-risk scoring.

struct PopulationScenario {
    name: &'static str,
    growth_rate: f64,
    carrying_capacity: f64,
    harvest: f64,
    catastrophe_probability: f64,
    connectivity: f64,
}

fn persistence_score(scenario: &PopulationScenario) -> f64 {
    0.35 * scenario.growth_rate
        + 0.25 * (scenario.carrying_capacity / 650.0)
        + 0.20 * scenario.connectivity
        - 0.10 * (scenario.harvest / 20.0)
        - 0.10 * scenario.catastrophe_probability
}

fn risk_class(score: f64) -> &'static str {
    if score >= 0.45 {
        "higher-persistence"
    } else if score >= 0.25 {
        "moderate-persistence"
    } else {
        "higher-risk"
    }
}

fn main() {
    let scenarios = vec![
        PopulationScenario { name: "baseline", growth_rate: 0.18, carrying_capacity: 500.0, harvest: 5.0, catastrophe_probability: 0.05, connectivity: 0.70 },
        PopulationScenario { name: "higher_harvest", growth_rate: 0.18, carrying_capacity: 500.0, harvest: 15.0, catastrophe_probability: 0.05, connectivity: 0.70 },
        PopulationScenario { name: "lower_capacity", growth_rate: 0.15, carrying_capacity: 300.0, harvest: 5.0, catastrophe_probability: 0.06, connectivity: 0.55 },
        PopulationScenario { name: "restoration_gain", growth_rate: 0.20, carrying_capacity: 650.0, harvest: 3.0, catastrophe_probability: 0.03, connectivity: 0.85 },
    ];

    for scenario in scenarios {
        let score = persistence_score(&scenario);
        println!(
            "scenario={} persistence_score={:.3} risk_class={}",
            scenario.name,
            score,
            risk_class(score)
        );
    }
}
