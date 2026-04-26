// Safe ecological reorganization risk utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent risk scoring.

struct Site {
    name: &'static str,
    mean_turnover: f64,
    productivity: f64,
    nutrient_retention: f64,
    disturbance_pressure: f64,
    connectivity: f64,
}

fn reorganization_risk(site: &Site, max_turnover: f64, max_productivity: f64, max_nutrient_retention: f64) -> f64 {
    0.20 * (site.mean_turnover / max_turnover)
        + 0.25 * site.disturbance_pressure
        + 0.20 * (1.0 - site.connectivity)
        - 0.15 * (site.productivity / max_productivity)
        - 0.20 * (site.nutrient_retention / max_nutrient_retention)
}

fn risk_class(score: f64) -> &'static str {
    if score >= 0.15 {
        "higher-reorganization-risk"
    } else if score >= 0.00 {
        "moderate-reorganization-risk"
    } else {
        "lower-reorganization-risk"
    }
}

fn main() {
    let sites = vec![
        Site { name: "site_A", mean_turnover: 0.42, productivity: 0.82, nutrient_retention: 0.79, disturbance_pressure: 0.20, connectivity: 0.85 },
        Site { name: "site_B", mean_turnover: 0.38, productivity: 0.76, nutrient_retention: 0.71, disturbance_pressure: 0.28, connectivity: 0.70 },
        Site { name: "site_C", mean_turnover: 0.51, productivity: 0.61, nutrient_retention: 0.55, disturbance_pressure: 0.60, connectivity: 0.42 },
        Site { name: "site_D", mean_turnover: 0.47, productivity: 0.70, nutrient_retention: 0.63, disturbance_pressure: 0.45, connectivity: 0.58 },
        Site { name: "site_E", mean_turnover: 0.40, productivity: 0.74, nutrient_retention: 0.68, disturbance_pressure: 0.33, connectivity: 0.66 },
    ];

    let max_turnover = 0.51;
    let max_productivity = 0.82;
    let max_nutrient_retention = 0.79;

    for site in sites {
        let score = reorganization_risk(&site, max_turnover, max_productivity, max_nutrient_retention);
        println!(
            "site={} reorganization_risk={:.3} risk_class={}",
            site.name,
            score,
            risk_class(score)
        );
    }
}
