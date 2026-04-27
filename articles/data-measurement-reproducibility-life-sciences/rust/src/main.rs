// Safe measurement quality summary utility in Rust.

fn mean(values: &[f64]) -> f64 {
    values.iter().sum::<f64>() / values.len() as f64
}

fn sample_sd(values: &[f64]) -> f64 {
    let m = mean(values);
    let sumsq: f64 = values.iter().map(|v| (v - m).powi(2)).sum();
    (sumsq / (values.len() as f64 - 1.0)).sqrt()
}

fn combined_uncertainty(components: &[f64]) -> f64 {
    components.iter().map(|v| v.powi(2)).sum::<f64>().sqrt()
}

fn main() {
    let values = vec![10.2, 10.5, 10.1, 10.4, 10.8, 10.7, 10.6, 10.3, 10.9, 10.4];
    let components = vec![0.08, 0.05, 0.11, 0.06];

    let mean_value = mean(&values);
    let sd_value = sample_sd(&values);
    let cv = sd_value / mean_value;
    let uc = combined_uncertainty(&components);
    let expanded = 2.0 * uc;

    println!("mean_value={:.5}", mean_value);
    println!("sample_sd={:.5}", sd_value);
    println!("coefficient_of_variation={:.5}", cv);
    println!("combined_standard_uncertainty={:.5}", uc);
    println!("expanded_uncertainty={:.5}", expanded);
}
