// Safe reproductive continuity scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates transparent life-history scoring.

struct LifeHistoryUnit {
    name: &'static str,
    fecundity: f64,
    juvenile_survival: f64,
    adult_survival: f64,
    maturation_rate: f64,
    dormancy_or_buffering: f64,
    environmental_stress: f64,
}

fn continuity_score(unit: &LifeHistoryUnit, max_fecundity: f64) -> f64 {
    0.20 * (unit.fecundity / max_fecundity)
        + 0.20 * unit.juvenile_survival
        + 0.25 * unit.adult_survival
        + 0.15 * unit.maturation_rate
        + 0.10 * unit.dormancy_or_buffering
        - 0.20 * unit.environmental_stress
}

fn continuity_class(score: f64) -> &'static str {
    if score >= 0.60 {
        "relatively-buffered"
    } else if score >= 0.45 {
        "vulnerable"
    } else {
        "high-risk"
    }
}

fn main() {
    let units = vec![
        LifeHistoryUnit { name: "A", fecundity: 2.4, juvenile_survival: 0.35, adult_survival: 0.82, maturation_rate: 0.50, dormancy_or_buffering: 0.40, environmental_stress: 0.25 },
        LifeHistoryUnit { name: "B", fecundity: 1.9, juvenile_survival: 0.55, adult_survival: 0.88, maturation_rate: 0.40, dormancy_or_buffering: 0.52, environmental_stress: 0.20 },
        LifeHistoryUnit { name: "C", fecundity: 3.1, juvenile_survival: 0.22, adult_survival: 0.60, maturation_rate: 0.65, dormancy_or_buffering: 0.30, environmental_stress: 0.50 },
        LifeHistoryUnit { name: "D", fecundity: 1.3, juvenile_survival: 0.68, adult_survival: 0.92, maturation_rate: 0.30, dormancy_or_buffering: 0.60, environmental_stress: 0.18 },
        LifeHistoryUnit { name: "E", fecundity: 2.2, juvenile_survival: 0.40, adult_survival: 0.76, maturation_rate: 0.48, dormancy_or_buffering: 0.45, environmental_stress: 0.32 },
    ];

    let max_fecundity = 3.1;

    for unit in units {
        let score = continuity_score(&unit, max_fecundity);
        println!(
            "unit={} continuity_score={:.3} continuity_class={}",
            unit.name,
            score,
            continuity_class(score)
        );
    }
}
