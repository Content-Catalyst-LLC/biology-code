// Safe habitability-support scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent weighted screening.

#[derive(Debug)]
struct HabitabilityUnit {
    name: &'static str,
    carbon_uptake_capacity: f64,
    water_regulation: f64,
    nitrogen_retention: f64,
    phosphorus_buffering: f64,
    oxygen_stability: f64,
    disturbance_pressure: f64,
    acidification_pressure: f64,
    nutrient_loading: f64,
}

fn habitability_support(unit: &HabitabilityUnit) -> f64 {
    0.18 * unit.carbon_uptake_capacity
        + 0.16 * unit.water_regulation
        + 0.14 * unit.nitrogen_retention
        + 0.14 * unit.phosphorus_buffering
        + 0.16 * unit.oxygen_stability
        - 0.10 * unit.disturbance_pressure
        - 0.06 * unit.acidification_pressure
        - 0.06 * unit.nutrient_loading
}

fn risk_class(score: f64) -> &'static str {
    if score >= 0.65 {
        "relatively-buffered"
    } else if score >= 0.45 {
        "stressed"
    } else {
        "high-risk"
    }
}

fn main() {
    let units = vec![
        HabitabilityUnit { name: "A", carbon_uptake_capacity: 0.82, water_regulation: 0.79, nitrogen_retention: 0.75, phosphorus_buffering: 0.73, oxygen_stability: 0.84, disturbance_pressure: 0.24, acidification_pressure: 0.21, nutrient_loading: 0.28 },
        HabitabilityUnit { name: "B", carbon_uptake_capacity: 0.66, water_regulation: 0.62, nitrogen_retention: 0.58, phosphorus_buffering: 0.61, oxygen_stability: 0.67, disturbance_pressure: 0.40, acidification_pressure: 0.35, nutrient_loading: 0.46 },
        HabitabilityUnit { name: "C", carbon_uptake_capacity: 0.51, water_regulation: 0.48, nitrogen_retention: 0.36, phosphorus_buffering: 0.42, oxygen_stability: 0.39, disturbance_pressure: 0.74, acidification_pressure: 0.69, nutrient_loading: 0.81 },
        HabitabilityUnit { name: "D", carbon_uptake_capacity: 0.88, water_regulation: 0.85, nitrogen_retention: 0.81, phosphorus_buffering: 0.79, oxygen_stability: 0.87, disturbance_pressure: 0.18, acidification_pressure: 0.14, nutrient_loading: 0.20 },
        HabitabilityUnit { name: "E", carbon_uptake_capacity: 0.59, water_regulation: 0.55, nitrogen_retention: 0.49, phosphorus_buffering: 0.46, oxygen_stability: 0.53, disturbance_pressure: 0.58, acidification_pressure: 0.51, nutrient_loading: 0.63 },
    ];

    for unit in units {
        let score = habitability_support(&unit);
        println!(
            "unit={} habitability_support={:.3} risk_class={}",
            unit.name,
            score,
            risk_class(score)
        );
    }
}
