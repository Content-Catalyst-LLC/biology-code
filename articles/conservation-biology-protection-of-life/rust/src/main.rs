// Safe conservation priority scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent weighted scoring.

#[derive(Debug)]
struct ConservationUnit {
    name: &'static str,
    extinction_risk: f64,
    endemism: f64,
    habitat_loss: f64,
    fragmentation: f64,
    recovery_potential: f64,
    cost_index: f64,
}

fn priority_score(unit: &ConservationUnit) -> f64 {
    0.30 * unit.extinction_risk
        + 0.20 * unit.endemism
        + 0.20 * unit.habitat_loss
        + 0.15 * unit.fragmentation
        + 0.10 * unit.recovery_potential
        - 0.05 * unit.cost_index
}

fn main() {
    let mut units = vec![
        ConservationUnit { name: "A", extinction_risk: 0.92, endemism: 0.80, habitat_loss: 0.75, fragmentation: 0.88, recovery_potential: 0.45, cost_index: 0.60 },
        ConservationUnit { name: "B", extinction_risk: 0.65, endemism: 0.30, habitat_loss: 0.90, fragmentation: 0.70, recovery_potential: 0.80, cost_index: 0.45 },
        ConservationUnit { name: "C", extinction_risk: 0.40, endemism: 0.25, habitat_loss: 0.35, fragmentation: 0.40, recovery_potential: 0.70, cost_index: 0.30 },
        ConservationUnit { name: "D", extinction_risk: 0.85, endemism: 0.95, habitat_loss: 0.60, fragmentation: 0.92, recovery_potential: 0.35, cost_index: 0.75 },
        ConservationUnit { name: "E", extinction_risk: 0.55, endemism: 0.50, habitat_loss: 0.70, fragmentation: 0.60, recovery_potential: 0.65, cost_index: 0.50 },
    ];

    units.sort_by(|a, b| priority_score(b).partial_cmp(&priority_score(a)).unwrap());

    for unit in units {
        println!("unit={} priority_score={:.3}", unit.name, priority_score(&unit));
    }
}
