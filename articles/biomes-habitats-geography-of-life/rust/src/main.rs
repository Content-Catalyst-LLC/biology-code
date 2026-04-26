// Safe habitat-priority scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent spatial priority scoring.

#[derive(Debug)]
struct HabitatSite {
    name: &'static str,
    precipitation_scaled: f64,
    soil_quality: f64,
    connectivity: f64,
    disturbance: f64,
    land_use_pressure: f64,
}

fn spatial_priority(site: &HabitatSite) -> f64 {
    0.25 * site.precipitation_scaled
        + 0.25 * site.soil_quality
        + 0.25 * site.connectivity
        - 0.15 * site.disturbance
        - 0.10 * site.land_use_pressure
}

fn priority_class(score: f64) -> &'static str {
    if score >= 0.55 {
        "high"
    } else if score >= 0.35 {
        "medium"
    } else {
        "low"
    }
}

fn main() {
    let sites = vec![
        HabitatSite { name: "S1", precipitation_scaled: 0.773, soil_quality: 0.72, connectivity: 0.80, disturbance: 0.20, land_use_pressure: 0.25 },
        HabitatSite { name: "S2", precipitation_scaled: 0.827, soil_quality: 0.81, connectivity: 0.74, disturbance: 0.24, land_use_pressure: 0.30 },
        HabitatSite { name: "S3", precipitation_scaled: 0.709, soil_quality: 0.60, connectivity: 0.55, disturbance: 0.45, land_use_pressure: 0.48 },
        HabitatSite { name: "S4", precipitation_scaled: 0.564, soil_quality: 0.52, connectivity: 0.40, disturbance: 0.61, land_use_pressure: 0.60 },
        HabitatSite { name: "S5", precipitation_scaled: 0.900, soil_quality: 0.88, connectivity: 0.89, disturbance: 0.18, land_use_pressure: 0.18 },
    ];

    for site in sites {
        let score = spatial_priority(&site);
        println!(
            "site={} spatial_priority={:.3} priority_class={}",
            site.name,
            score,
            priority_class(score)
        );
    }
}
