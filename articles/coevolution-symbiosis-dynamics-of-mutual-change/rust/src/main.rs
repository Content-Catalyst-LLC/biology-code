// Safe symbiosis condition scoring utility in Rust.

struct SymbiosisSite {
    name: &'static str,
    partner_presence: f64,
    interaction_stability: f64,
    environmental_stress: f64,
    cheating_pressure: f64,
    transmission_reliability: f64,
    functional_redundancy: f64,
}

fn condition_score(site: &SymbiosisSite) -> f64 {
    0.22 * site.partner_presence
        + 0.22 * site.interaction_stability
        + 0.18 * site.transmission_reliability
        + 0.16 * site.functional_redundancy
        + 0.12 * (1.0 - site.environmental_stress)
        + 0.10 * (1.0 - site.cheating_pressure)
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
        SymbiosisSite { name: "reference_reef", partner_presence: 0.88, interaction_stability: 0.78, environmental_stress: 0.20, cheating_pressure: 0.12, transmission_reliability: 0.82, functional_redundancy: 0.66 },
        SymbiosisSite { name: "warming_stressed_reef", partner_presence: 0.62, interaction_stability: 0.45, environmental_stress: 0.74, cheating_pressure: 0.18, transmission_reliability: 0.56, functional_redundancy: 0.38 },
        SymbiosisSite { name: "restored_prairie", partner_presence: 0.70, interaction_stability: 0.63, environmental_stress: 0.35, cheating_pressure: 0.20, transmission_reliability: 0.68, functional_redundancy: 0.55 },
        SymbiosisSite { name: "degraded_soil_site", partner_presence: 0.41, interaction_stability: 0.34, environmental_stress: 0.62, cheating_pressure: 0.31, transmission_reliability: 0.42, functional_redundancy: 0.29 },
    ];

    for site in sites {
        let score = condition_score(&site);
        println!(
            "site={} symbiosis_condition_score={:.3} condition_class={}",
            site.name,
            score,
            condition_class(score)
        );
    }
}
