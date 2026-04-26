// Safe microbial condition scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent microbial condition scoring.

struct MicrobialSite {
    name: &'static str,
    functional_richness: f64,
    nitrification_potential: f64,
    denitrification_balance: f64,
    pathogen_signal: f64,
    organic_overload: f64,
}

fn condition_index(site: &MicrobialSite) -> f64 {
    0.30 * site.functional_richness
        + 0.20 * site.nitrification_potential
        + 0.20 * site.denitrification_balance
        + 0.15 * (1.0 - site.pathogen_signal)
        + 0.15 * (1.0 - site.organic_overload)
}

fn condition_class(score: f64) -> &'static str {
    if score < 0.50 {
        "high-concern"
    } else if score < 0.70 {
        "moderate"
    } else {
        "strong"
    }
}

fn main() {
    let sites = vec![
        MicrobialSite { name: "reference_wetland", functional_richness: 0.82, nitrification_potential: 0.74, denitrification_balance: 0.71, pathogen_signal: 0.10, organic_overload: 0.18 },
        MicrobialSite { name: "restored_marsh", functional_richness: 0.67, nitrification_potential: 0.58, denitrification_balance: 0.60, pathogen_signal: 0.16, organic_overload: 0.25 },
        MicrobialSite { name: "eutrophic_pond", functional_richness: 0.39, nitrification_potential: 0.33, denitrification_balance: 0.29, pathogen_signal: 0.31, organic_overload: 0.77 },
        MicrobialSite { name: "agricultural_drainage", functional_richness: 0.45, nitrification_potential: 0.49, denitrification_balance: 0.43, pathogen_signal: 0.27, organic_overload: 0.61 },
    ];

    for site in sites {
        let score = condition_index(&site);
        println!(
            "site={} condition_index={:.3} condition_class={}",
            site.name,
            score,
            condition_class(score)
        );
    }
}
