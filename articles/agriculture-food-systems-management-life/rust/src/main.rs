// Safe command-line resilience-ranking utility for synthetic food-system examples.

#[derive(Debug)]
struct FarmSystem {
    name: &'static str,
    crop_diversity: f64,
    soil_function: f64,
    landscape_heterogeneity: f64,
    pollinator_habitat: f64,
    natural_enemy_habitat: f64,
}

fn resilience_index(item: &FarmSystem) -> f64 {
    0.25 * item.crop_diversity
        + 0.25 * item.soil_function
        + 0.20 * item.landscape_heterogeneity
        + 0.15 * item.pollinator_habitat
        + 0.15 * item.natural_enemy_habitat
}

fn main() {
    let systems = vec![
        FarmSystem { name: "monocrop_grain", crop_diversity: 0.20, soil_function: 0.35, landscape_heterogeneity: 0.25, pollinator_habitat: 0.18, natural_enemy_habitat: 0.22 },
        FarmSystem { name: "diversified_crop", crop_diversity: 0.65, soil_function: 0.70, landscape_heterogeneity: 0.60, pollinator_habitat: 0.62, natural_enemy_habitat: 0.58 },
        FarmSystem { name: "agroforestry", crop_diversity: 0.80, soil_function: 0.82, landscape_heterogeneity: 0.88, pollinator_habitat: 0.84, natural_enemy_habitat: 0.78 },
    ];

    for system in &systems {
        println!("{} resilience_index={:.5}", system.name, resilience_index(system));
    }
}
