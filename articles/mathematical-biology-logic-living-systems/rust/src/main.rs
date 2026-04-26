// Safe mathematical-biology summary utility in Rust.

fn logistic_growth(t: f64, n0: f64, r: f64, k: f64) -> f64 {
    k / (1.0 + ((k - n0) / n0) * (-r * t).exp())
}

fn michaelis_menten(substrate: f64, vmax: f64, km: f64) -> f64 {
    vmax * substrate / (km + substrate)
}

fn sir_summary(beta: f64, gamma: f64, dt: f64, time_end: f64) -> (f64, f64, f64) {
    let mut s = 0.99;
    let mut i = 0.01;
    let mut r_comp = 0.0;
    let mut peak_i = i;
    let mut time_to_peak = 0.0;
    let n_steps = (time_end / dt).floor() as usize;

    for step in 0..n_steps {
        let time = step as f64 * dt;

        if i > peak_i {
            peak_i = i;
            time_to_peak = time;
        }

        let ds = -beta * s * i;
        let di = beta * s * i - gamma * i;
        let dr = gamma * i;

        s = (s + ds * dt).max(0.0);
        i = (i + di * dt).max(0.0);
        r_comp = (r_comp + dr * dt).max(0.0);
    }

    (peak_i, time_to_peak, r_comp)
}

fn main() {
    let logistic_final = logistic_growth(40.0, 100.0, 0.30, 2000.0);
    let velocity = michaelis_menten(5.0, 10.0, 2.0);
    let (peak_i, time_to_peak, final_recovered) = sir_summary(0.35, 0.10, 0.05, 120.0);

    println!("logistic_final={:.4}", logistic_final);
    println!("michaelis_menten_velocity={:.4}", velocity);
    println!("sir_peak_infected={:.6}", peak_i);
    println!("sir_time_to_peak={:.3}", time_to_peak);
    println!("sir_final_recovered={:.6}", final_recovered);
}
