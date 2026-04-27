// Safe statistics and measurement summary utility in Rust.

fn mean(values: &[f64]) -> f64 {
    values.iter().sum::<f64>() / values.len() as f64
}

fn sample_sd(values: &[f64]) -> f64 {
    let m = mean(values);
    let sumsq: f64 = values.iter().map(|v| (v - m).powi(2)).sum();
    (sumsq / (values.len() as f64 - 1.0)).sqrt()
}

fn combined_uncertainty(components: &[f64]) -> f64 {
    components.iter().map(|u| u * u).sum::<f64>().sqrt()
}

fn main() {
    let values = vec![10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4, 11.3, 10.7];
    let m = mean(&values);
    let sd = sample_sd(&values);
    let se = sd / (values.len() as f64).sqrt();

    let components = vec![0.12, 0.08, 0.15, 0.06, 0.05];
    let uc = combined_uncertainty(&components);

    println!("mean={:.5}", m);
    println!("standard_deviation={:.5}", sd);
    println!("standard_error={:.5}", se);
    println!("ci_lower={:.5}", m - 1.96 * se);
    println!("ci_upper={:.5}", m + 1.96 * se);
    println!("combined_standard_uncertainty={:.5}", uc);
    println!("expanded_uncertainty={:.5}", 2.0 * uc);
}
