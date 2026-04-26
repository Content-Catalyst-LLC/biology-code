// Assay validation utility in Rust.

struct Assay {
    name: &'static str,
    true_positive: f64,
    false_negative: f64,
    true_negative: f64,
    false_positive: f64,
}

fn sensitivity(a: &Assay) -> f64 {
    a.true_positive / (a.true_positive + a.false_negative)
}

fn specificity(a: &Assay) -> f64 {
    a.true_negative / (a.true_negative + a.false_positive)
}

fn ppv(a: &Assay) -> f64 {
    a.true_positive / (a.true_positive + a.false_positive)
}

fn npv(a: &Assay) -> f64 {
    a.true_negative / (a.true_negative + a.false_negative)
}

fn accuracy(a: &Assay) -> f64 {
    (a.true_positive + a.true_negative)
        / (a.true_positive + a.false_negative + a.true_negative + a.false_positive)
}

fn main() {
    let assays = vec![
        Assay { name: "biosensor_A", true_positive: 84.0, false_negative: 16.0, true_negative: 91.0, false_positive: 9.0 },
        Assay { name: "biosensor_B", true_positive: 76.0, false_negative: 24.0, true_negative: 95.0, false_positive: 5.0 },
        Assay { name: "sequence_test_A", true_positive: 92.0, false_negative: 8.0, true_negative: 88.0, false_positive: 12.0 },
    ];

    for a in assays {
        println!(
            "assay={} sensitivity={:.3} specificity={:.3} ppv={:.3} npv={:.3} accuracy={:.3}",
            a.name,
            sensitivity(&a),
            specificity(&a),
            ppv(&a),
            npv(&a),
            accuracy(&a)
        );
    }
}
