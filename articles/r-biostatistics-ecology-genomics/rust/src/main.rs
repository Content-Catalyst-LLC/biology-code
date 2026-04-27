// Safe biological summary utility in Rust.

fn mean(values: &[f64]) -> f64 {
    values.iter().sum::<f64>() / values.len() as f64
}

fn sample_sd(values: &[f64]) -> f64 {
    let m = mean(values);
    let sumsq: f64 = values.iter().map(|v| (v - m).powi(2)).sum();
    (sumsq / (values.len() as f64 - 1.0)).sqrt()
}

fn shannon_diversity(counts: &[f64]) -> f64 {
    let positive: Vec<f64> = counts.iter().cloned().filter(|x| *x > 0.0).collect();
    let total: f64 = positive.iter().sum();

    positive
        .iter()
        .map(|c| {
            let p = c / total;
            -p * p.ln()
        })
        .sum()
}

fn log2_fold_change(control: &[f64], treated: &[f64], pseudocount: f64) -> f64 {
    ((mean(treated) + pseudocount) / (mean(control) + pseudocount)).log2()
}

fn main() {
    let control = vec![10.2, 10.5, 10.1, 10.4, 10.3, 10.6];
    let treated = vec![12.1, 12.4, 11.9, 12.0, 12.5];
    let counts = vec![18.0, 7.0, 3.0, 0.0];
    let gene_control = vec![120.0, 130.0, 125.0];
    let gene_treated = vec![300.0, 310.0, 290.0];

    println!("control_mean={:.5}", mean(&control));
    println!("treated_mean={:.5}", mean(&treated));
    println!("control_sd={:.5}", sample_sd(&control));
    println!("shannon_diversity={:.5}", shannon_diversity(&counts));
    println!("gene_log2_fold_change={:.5}", log2_fold_change(&gene_control, &gene_treated, 1.0));
}
