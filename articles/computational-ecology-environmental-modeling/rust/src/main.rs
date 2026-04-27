// Safe computational ecology summary utility in Rust.

fn logistic(x: f64) -> f64 {
    1.0 / (1.0 + (-x).exp())
}

fn habitat_suitability(temperature_c: f64, precipitation_mm: f64, habitat_quality: f64, disturbance: f64) -> f64 {
    let score = -2.0
        + 0.05 * temperature_c
        + 0.0015 * precipitation_mm
        + 2.4 * habitat_quality
        - 2.0 * disturbance;

    logistic(score)
}

fn patch_occupancy(initial_occupancy: f64, colonization: f64, extinction: f64, steps: usize) -> f64 {
    let mut occupancy = initial_occupancy;

    for _ in 0..steps {
        occupancy = occupancy * (1.0 - extinction) + (1.0 - occupancy) * colonization;
        occupancy = occupancy.clamp(0.0, 1.0);
    }

    occupancy
}

fn runoff(precipitation_mm: f64, infiltration_fraction: f64, runoff_coefficient: f64) -> f64 {
    precipitation_mm * (1.0 - infiltration_fraction) * runoff_coefficient
}

fn main() {
    println!("suitability={:.5}", habitat_suitability(16.2, 820.0, 0.82, 0.18));
    println!("final_occupancy={:.5}", patch_occupancy(0.42, 0.12, 0.08, 30));
    println!("runoff_mm={:.5}", runoff(42.0, 0.62, 0.30));
}
