// Safe biosphere functional-integrity scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent weighted scoring.

#[derive(Debug)]
struct BiosphereUnit {
    name: &'static str,
    primary_production: f64,
    water_regulation: f64,
    nutrient_retention: f64,
    habitat_complexity: f64,
    connectivity: f64,
    disturbance_pressure: f64,
    biodiversity_signal: f64,
}

fn functional_integrity(unit: &BiosphereUnit) -> f64 {
    0.20 * unit.primary_production
        + 0.18 * unit.water_regulation
        + 0.18 * unit.nutrient_retention
        + 0.18 * unit.habitat_complexity
        + 0.12 * unit.connectivity
        + 0.14 * unit.biodiversity_signal
        - 0.20 * unit.disturbance_pressure
}

fn risk_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "stable-to-watch"
    } else if score >= 0.50 {
        "stressed"
    } else {
        "high-risk"
    }
}

fn main() {
    let units = vec![
        BiosphereUnit { name: "A", primary_production: 0.86, water_regulation: 0.82, nutrient_retention: 0.79, habitat_complexity: 0.91, connectivity: 0.84, disturbance_pressure: 0.24, biodiversity_signal: 0.88 },
        BiosphereUnit { name: "B", primary_production: 0.73, water_regulation: 0.69, nutrient_retention: 0.70, habitat_complexity: 0.64, connectivity: 0.51, disturbance_pressure: 0.41, biodiversity_signal: 0.66 },
        BiosphereUnit { name: "C", primary_production: 0.61, water_regulation: 0.58, nutrient_retention: 0.49, habitat_complexity: 0.42, connectivity: 0.38, disturbance_pressure: 0.72, biodiversity_signal: 0.44 },
        BiosphereUnit { name: "D", primary_production: 0.91, water_regulation: 0.88, nutrient_retention: 0.85, habitat_complexity: 0.94, connectivity: 0.90, disturbance_pressure: 0.18, biodiversity_signal: 0.92 },
        BiosphereUnit { name: "E", primary_production: 0.67, water_regulation: 0.63, nutrient_retention: 0.57, habitat_complexity: 0.55, connectivity: 0.48, disturbance_pressure: 0.56, biodiversity_signal: 0.59 },
    ];

    for unit in units {
        let score = functional_integrity(&unit);
        println!(
            "unit={} functional_integrity={:.3} risk_class={}",
            unit.name,
            score,
            risk_class(score)
        );
    }
}
