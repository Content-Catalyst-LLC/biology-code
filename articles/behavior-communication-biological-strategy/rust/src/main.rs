// Safe behavioral strategy scoring utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It demonstrates utility scoring for behavioral options.

struct BehavioralOption {
    name: &'static str,
    benefit: f64,
    energetic_cost: f64,
    predation_risk: f64,
}

fn utility(option: &BehavioralOption, predation_weight: f64) -> f64 {
    option.benefit - 0.8 * option.energetic_cost - predation_weight * option.predation_risk
}

fn strategy_class(score: f64) -> &'static str {
    if score >= 5.0 {
        "favored"
    } else if score >= 2.0 {
        "context-dependent"
    } else {
        "disfavored"
    }
}

fn main() {
    let options = vec![
        BehavioralOption { name: "safe_foraging", benefit: 8.0, energetic_cost: 2.0, predation_risk: 1.0 },
        BehavioralOption { name: "risky_foraging", benefit: 14.0, energetic_cost: 5.0, predation_risk: 6.0 },
        BehavioralOption { name: "territorial_display", benefit: 10.0, energetic_cost: 4.0, predation_risk: 3.0 },
        BehavioralOption { name: "mate_search", benefit: 12.0, energetic_cost: 6.0, predation_risk: 5.0 },
    ];

    for option in options {
        let score = utility(&option, 1.2);
        println!(
            "option={} utility={:.3} strategy_class={}",
            option.name,
            score,
            strategy_class(score)
        );
    }
}
