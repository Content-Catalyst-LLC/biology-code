// Safe biostatistics design summary utility in Rust.

fn mean(values: &[f64]) -> f64 {
    values.iter().sum::<f64>() / values.len() as f64
}

fn sample_sd(values: &[f64]) -> f64 {
    let m = mean(values);
    let sumsq: f64 = values.iter().map(|v| (v - m).powi(2)).sum();
    (sumsq / (values.len() as f64 - 1.0)).sqrt()
}

fn main() {
    let control = vec![10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4];
    let treated = vec![12.1, 11.7, 12.4, 11.9, 12.0, 12.6, 11.8, 12.3];

    let mean0 = mean(&control);
    let mean1 = mean(&treated);
    let sd0 = sample_sd(&control);
    let sd1 = sample_sd(&treated);

    let n0 = control.len() as f64;
    let n1 = treated.len() as f64;

    let pooled_sd = (((n0 - 1.0) * sd0.powi(2) + (n1 - 1.0) * sd1.powi(2)) / (n0 + n1 - 2.0)).sqrt();
    let difference = mean1 - mean0;
    let effect_size_d = difference / pooled_sd;
    let se_difference = (sd0.powi(2) / n0 + sd1.powi(2) / n1).sqrt();
    let approx_n = 2.0 * (1.96_f64 + 0.84_f64).powi(2) / 0.8_f64.powi(2);

    println!("control_mean={:.5}", mean0);
    println!("treated_mean={:.5}", mean1);
    println!("mean_difference={:.5}", difference);
    println!("pooled_sd={:.5}", pooled_sd);
    println!("effect_size_d={:.5}", effect_size_d);
    println!("se_difference={:.5}", se_difference);
    println!("approx_n_per_group_for_d_0_8={:.3}", approx_n);
}
