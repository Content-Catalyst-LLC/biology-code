// Safe animal condition scoring utility in Rust.

struct AnimalSite {
    name: &'static str,
    habitat_quality: f64,
    food_availability: f64,
    disease_pressure: f64,
    heat_stress: f64,
    reproductive_support: f64,
    movement_connectivity: f64,
}

fn condition_score(site: &AnimalSite) -> f64 {
    0.24 * site.habitat_quality
        + 0.20 * site.food_availability
        + 0.18 * site.reproductive_support
        + 0.18 * site.movement_connectivity
        + 0.10 * (1.0 - site.disease_pressure)
        + 0.10 * (1.0 - site.heat_stress)
}

fn condition_class(score: f64) -> &'static str {
    if score < 0.55 {
        "high-concern"
    } else if score < 0.72 {
        "moderate"
    } else {
        "strong"
    }
}

fn main() {
    let sites = vec![
        AnimalSite { name: "reference_reserve", habitat_quality: 0.86, food_availability: 0.82, disease_pressure: 0.08, heat_stress: 0.16, reproductive_support: 0.80, movement_connectivity: 0.78 },
        AnimalSite { name: "fragmented_woodland", habitat_quality: 0.52, food_availability: 0.58, disease_pressure: 0.18, heat_stress: 0.34, reproductive_support: 0.50, movement_connectivity: 0.35 },
        AnimalSite { name: "heat_stressed_wetland", habitat_quality: 0.61, food_availability: 0.55, disease_pressure: 0.21, heat_stress: 0.62, reproductive_support: 0.47, movement_connectivity: 0.51 },
        AnimalSite { name: "restored_corridor", habitat_quality: 0.72, food_availability: 0.69, disease_pressure: 0.13, heat_stress: 0.28, reproductive_support: 0.67, movement_connectivity: 0.76 },
    ];

    for site in sites {
        let score = condition_score(&site);
        println!(
            "site={} animal_condition_score={:.3} condition_class={}",
            site.name,
            score,
            condition_class(score)
        );
    }
}
