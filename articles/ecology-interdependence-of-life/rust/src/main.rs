// Safe ecological condition scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent scoring for ecological condition.

struct Site {
    name: &'static str,
    shannon: f64,
    mean_turnover: f64,
    productivity: f64,
    nutrient_retention: f64,
    disturbance_pressure: f64,
    connectivity: f64,
}

fn ecological_condition(site: &Site, max_shannon: f64) -> f64 {
    0.20 * (site.shannon / max_shannon)
        + 0.20 * site.productivity
        + 0.20 * site.nutrient_retention
        + 0.15 * site.connectivity
        - 0.15 * site.mean_turnover
        - 0.20 * site.disturbance_pressure
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.55 {
        "relatively-buffered"
    } else if score >= 0.35 {
        "stressed"
    } else {
        "high-risk"
    }
}

fn main() {
    let sites = vec![
        Site { name: "site_A", shannon: 1.41, mean_turnover: 0.37, productivity: 0.84, nutrient_retention: 0.80, disturbance_pressure: 0.18, connectivity: 0.86 },
        Site { name: "site_B", shannon: 1.39, mean_turnover: 0.34, productivity: 0.78, nutrient_retention: 0.74, disturbance_pressure: 0.27, connectivity: 0.73 },
        Site { name: "site_C", shannon: 1.39, mean_turnover: 0.42, productivity: 0.62, nutrient_retention: 0.58, disturbance_pressure: 0.61, connectivity: 0.41 },
        Site { name: "site_D", shannon: 1.40, mean_turnover: 0.39, productivity: 0.71, nutrient_retention: 0.64, disturbance_pressure: 0.44, connectivity: 0.56 },
        Site { name: "site_E", shannon: 1.53, mean_turnover: 0.32, productivity: 0.75, nutrient_retention: 0.70, disturbance_pressure: 0.30, connectivity: 0.68 },
    ];

    let max_shannon = 1.53;

    for site in sites {
        let score = ecological_condition(&site, max_shannon);
        println!(
            "site={} ecological_condition={:.3} condition_class={}",
            site.name,
            score,
            condition_class(score)
        );
    }
}
