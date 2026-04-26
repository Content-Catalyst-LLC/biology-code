// Safe life-definition scoring utility in Rust.

struct BorderlineCase {
    name: &'static str,
    organization: f64,
    metabolism: f64,
    autonomy: f64,
    heredity: f64,
    responsiveness: f64,
    evolutionary_capacity: f64,
}

fn heuristic_life_score(item: &BorderlineCase) -> f64 {
    0.18 * item.organization
        + 0.18 * item.metabolism
        + 0.16 * item.autonomy
        + 0.18 * item.heredity
        + 0.12 * item.responsiveness
        + 0.18 * item.evolutionary_capacity
}

fn category(score: f64) -> &'static str {
    if score >= 0.72 {
        "strongly_life_like_under_this_matrix"
    } else if score >= 0.45 {
        "borderline_or_context_dependent"
    } else {
        "weakly_life_like_under_this_matrix"
    }
}

fn main() {
    let cases = vec![
        BorderlineCase { name: "bacterium", organization: 0.95, metabolism: 0.90, autonomy: 0.88, heredity: 0.90, responsiveness: 0.85, evolutionary_capacity: 0.90 },
        BorderlineCase { name: "virus", organization: 0.55, metabolism: 0.05, autonomy: 0.10, heredity: 0.82, responsiveness: 0.25, evolutionary_capacity: 0.88 },
        BorderlineCase { name: "dormant_seed", organization: 0.80, metabolism: 0.20, autonomy: 0.45, heredity: 0.86, responsiveness: 0.40, evolutionary_capacity: 0.80 },
        BorderlineCase { name: "sterile_mule", organization: 0.95, metabolism: 0.88, autonomy: 0.92, heredity: 0.80, responsiveness: 0.90, evolutionary_capacity: 0.20 },
        BorderlineCase { name: "crystal", organization: 0.35, metabolism: 0.00, autonomy: 0.00, heredity: 0.00, responsiveness: 0.05, evolutionary_capacity: 0.00 },
    ];

    for item in cases {
        let score = heuristic_life_score(&item);
        println!(
            "case={} heuristic_life_score={:.3} category={}",
            item.name,
            score,
            category(score)
        );
    }
}
