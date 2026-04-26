// Safe fungal condition scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent fungal recovery scoring.

struct FungalSite {
    name: &'static str,
    mycorrhizal_inoculum: f64,
    saprotroph_activity: f64,
    soil_connectivity: f64,
    pathogen_pressure: f64,
    drought_stress: f64,
}

fn recovery_score(site: &FungalSite) -> f64 {
    0.30 * site.mycorrhizal_inoculum
        + 0.25 * site.saprotroph_activity
        + 0.20 * site.soil_connectivity
        + 0.15 * (1.0 - site.pathogen_pressure)
        + 0.10 * (1.0 - site.drought_stress)
}

fn priority_class(score: f64) -> &'static str {
    if score < 0.55 {
        "high-intervention"
    } else if score < 0.70 {
        "moderate-intervention"
    } else {
        "lower-intervention"
    }
}

fn main() {
    let sites = vec![
        FungalSite { name: "A", mycorrhizal_inoculum: 0.82, saprotroph_activity: 0.77, soil_connectivity: 0.74, pathogen_pressure: 0.12, drought_stress: 0.25 },
        FungalSite { name: "B", mycorrhizal_inoculum: 0.45, saprotroph_activity: 0.58, soil_connectivity: 0.50, pathogen_pressure: 0.21, drought_stress: 0.42 },
        FungalSite { name: "C", mycorrhizal_inoculum: 0.18, saprotroph_activity: 0.29, soil_connectivity: 0.35, pathogen_pressure: 0.33, drought_stress: 0.68 },
        FungalSite { name: "D", mycorrhizal_inoculum: 0.61, saprotroph_activity: 0.65, soil_connectivity: 0.69, pathogen_pressure: 0.19, drought_stress: 0.37 },
    ];

    for site in sites {
        let score = recovery_score(&site);
        println!(
            "site={} recovery_score={:.3} priority_class={}",
            site.name,
            score,
            priority_class(score)
        );
    }
}
