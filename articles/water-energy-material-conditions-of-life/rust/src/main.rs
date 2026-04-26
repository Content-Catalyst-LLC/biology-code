// Safe material-condition scoring utility in Rust.

struct MaterialConditionCase {
    name: &'static str,
    water_availability: f64,
    osmotic_stability: f64,
    energy_availability: f64,
    oxygen_support: f64,
    thermal_suitability: f64,
    ph_stability: f64,
    stress_penalty: f64,
}

fn material_condition_score(case: &MaterialConditionCase) -> f64 {
    0.17 * case.water_availability
        + 0.15 * case.osmotic_stability
        + 0.17 * case.energy_availability
        + 0.14 * case.oxygen_support
        + 0.13 * case.thermal_suitability
        + 0.14 * case.ph_stability
        + 0.10 * (1.0 - case.stress_penalty)
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.72 {
        "strong_material_conditions"
    } else if score >= 0.52 {
        "moderate_material_conditions"
    } else {
        "constrained_or_high_uncertainty_conditions"
    }
}

fn main() {
    let cases = vec![
        MaterialConditionCase { name: "reference_cell_state", water_availability: 0.86, osmotic_stability: 0.82, energy_availability: 0.84, oxygen_support: 0.80, thermal_suitability: 0.78, ph_stability: 0.82, stress_penalty: 0.18 },
        MaterialConditionCase { name: "dehydration_state", water_availability: 0.34, osmotic_stability: 0.46, energy_availability: 0.68, oxygen_support: 0.78, thermal_suitability: 0.72, ph_stability: 0.70, stress_penalty: 0.58 },
        MaterialConditionCase { name: "hypoxic_state", water_availability: 0.78, osmotic_stability: 0.74, energy_availability: 0.40, oxygen_support: 0.32, thermal_suitability: 0.70, ph_stability: 0.68, stress_penalty: 0.62 },
        MaterialConditionCase { name: "marine_acidification_state", water_availability: 0.82, osmotic_stability: 0.70, energy_availability: 0.66, oxygen_support: 0.72, thermal_suitability: 0.68, ph_stability: 0.38, stress_penalty: 0.55 },
        MaterialConditionCase { name: "thermal_stress_state", water_availability: 0.74, osmotic_stability: 0.70, energy_availability: 0.62, oxygen_support: 0.68, thermal_suitability: 0.30, ph_stability: 0.66, stress_penalty: 0.64 },
        MaterialConditionCase { name: "plant_drought_state", water_availability: 0.38, osmotic_stability: 0.48, energy_availability: 0.58, oxygen_support: 0.74, thermal_suitability: 0.66, ph_stability: 0.70, stress_penalty: 0.60 },
    ];

    for case in cases {
        let score = material_condition_score(&case);
        println!(
            "case={} material_condition_score={:.3} condition_class={}",
            case.name,
            score,
            condition_class(score)
        );
    }
}
