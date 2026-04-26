// Safe plant condition scoring utility in Rust.

struct PlantSite {
    name: &'static str,
    canopy_condition: f64,
    water_availability: f64,
    nutrient_status: f64,
    soil_function: f64,
    disease_pressure: f64,
    drought_stress: f64,
    regeneration_support: f64,
}

fn condition_score(site: &PlantSite) -> f64 {
    0.20 * site.canopy_condition
        + 0.18 * site.water_availability
        + 0.16 * site.nutrient_status
        + 0.16 * site.soil_function
        + 0.15 * site.regeneration_support
        + 0.08 * (1.0 - site.disease_pressure)
        + 0.07 * (1.0 - site.drought_stress)
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
        PlantSite { name: "reference_forest", canopy_condition: 0.86, water_availability: 0.78, nutrient_status: 0.74, soil_function: 0.82, disease_pressure: 0.10, drought_stress: 0.18, regeneration_support: 0.80 },
        PlantSite { name: "restoration_plot", canopy_condition: 0.62, water_availability: 0.56, nutrient_status: 0.59, soil_function: 0.54, disease_pressure: 0.17, drought_stress: 0.35, regeneration_support: 0.61 },
        PlantSite { name: "drought_stressed_woodland", canopy_condition: 0.48, water_availability: 0.32, nutrient_status: 0.50, soil_function: 0.46, disease_pressure: 0.22, drought_stress: 0.68, regeneration_support: 0.39 },
        PlantSite { name: "riparian_repair_site", canopy_condition: 0.70, water_availability: 0.74, nutrient_status: 0.64, soil_function: 0.68, disease_pressure: 0.14, drought_stress: 0.28, regeneration_support: 0.72 },
    ];

    for site in sites {
        let score = condition_score(&site);
        println!(
            "site={} plant_condition_score={:.3} condition_class={}",
            site.name,
            score,
            condition_class(score)
        );
    }
}
