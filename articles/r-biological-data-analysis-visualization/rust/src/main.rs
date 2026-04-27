// Safe biological summary utility in Rust.

fn mean(values: &[f64]) -> f64 {
    values.iter().sum::<f64>() / values.len() as f64
}

fn sample_sd(values: &[f64]) -> f64 {
    let m = mean(values);
    let sumsq: f64 = values.iter().map(|v| (v - m).powi(2)).sum();
    (sumsq / (values.len() as f64 - 1.0)).sqrt()
}

fn coefficient_of_variation(values: &[f64]) -> f64 {
    sample_sd(values) / mean(values)
}

fn shannon_diversity(counts: &[f64]) -> f64 {
    let positive: Vec<f64> = counts.iter().cloned().filter(|x| *x > 0.0).collect();
    let total: f64 = positive.iter().sum();
    positive.iter().map(|c| {
        let p = c / total;
        -p * p.ln()
    }).sum()
}

fn main() {
    let control = vec![10.2, 10.5, 10.1, 10.4, 10.3, 10.6];
    let counts = vec![18.0, 7.0, 3.0, 0.0];

    println!("control_mean={:.5}", mean(&control));
    println!("control_sd={:.5}", sample_sd(&control));
    println!("control_cv={:.5}", coefficient_of_variation(&control));
    println!("shannon_diversity={:.5}", shannon_diversity(&counts));
}
