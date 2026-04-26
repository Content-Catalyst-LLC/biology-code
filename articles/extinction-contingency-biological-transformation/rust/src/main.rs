// Safe extinction condition scoring utility in Rust.

struct ExtinctionSite {
    name: &'static str,
    lineage_irreplaceability: f64,
    range_contraction: f64,
    habitat_fragmentation: f64,
    functional_uniqueness: f64,
    recovery_potential: f64,
    monitoring_confidence: f64,
}

fn condition_score(site: &ExtinctionSite) -> f64 {
    0.22 * site.lineage_irreplaceability
        + 0.20 * site.range_contraction
        + 0.20 * site.habitat_fragmentation
        + 0.18 * site.functional_uniqueness
        + 0.12 * (1.0 - site.recovery_potential)
        + 0.08 * site.monitoring_confidence
}

fn condition_class(score: f64) -> &'static str {
    if score >= 0.70 {
        "critical"
    } else if score >= 0.50 {
        "high_concern"
    } else {
        "watch"
    }
}

fn main() {
    let sites = vec![
        ExtinctionSite { name: "reference_refugium", lineage_irreplaceability: 0.70, range_contraction: 0.22, habitat_fragmentation: 0.18, functional_uniqueness: 0.64, recovery_potential: 0.76, monitoring_confidence: 0.82 },
        ExtinctionSite { name: "fragmented_endemism_zone", lineage_irreplaceability: 0.88, range_contraction: 0.71, habitat_fragmentation: 0.76, functional_uniqueness: 0.81, recovery_potential: 0.34, monitoring_confidence: 0.61 },
        ExtinctionSite { name: "degraded_freshwater_basin", lineage_irreplaceability: 0.76, range_contraction: 0.63, habitat_fragmentation: 0.69, functional_uniqueness: 0.72, recovery_potential: 0.42, monitoring_confidence: 0.58 },
        ExtinctionSite { name: "recovering_landscape", lineage_irreplaceability: 0.54, range_contraction: 0.36, habitat_fragmentation: 0.41, functional_uniqueness: 0.50, recovery_potential: 0.68, monitoring_confidence: 0.74 },
    ];

    for site in sites {
        let score = condition_score(&site);
        println!(
            "site={} extinction_condition_score={:.3} condition_class={}",
            site.name,
            score,
            condition_class(score)
        );
    }
}
