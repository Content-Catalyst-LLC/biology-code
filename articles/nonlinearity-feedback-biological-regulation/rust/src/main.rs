// Safe nonlinear feedback summary utility in Rust.

fn saturating_response(signal: f64, vmax: f64, k_half: f64) -> f64 {
    vmax * signal / (k_half + signal)
}

fn hill_response(signal: f64, k_half: f64, n: f64) -> f64 {
    signal.powf(n) / (k_half.powf(n) + signal.powf(n))
}

fn negative_feedback_final(x0: f64, set_point: f64, k: f64, dt: f64, t_end: f64) -> f64 {
    let steps = (t_end / dt).floor() as usize + 1;
    let mut x = x0;

    for _ in 1..steps {
        let dx = -k * (x - set_point);
        x += dx * dt;
    }

    x
}

fn positive_feedback_final(x0: f64, alpha: f64, beta: f64, k_half: f64, n: f64, dt: f64, t_end: f64) -> f64 {
    let steps = (t_end / dt).floor() as usize + 1;
    let mut x = x0;

    for _ in 1..steps {
        let production = alpha * x.powf(n) / (k_half.powf(n) + x.powf(n));
        let loss = beta * x;
        let dx = production - loss;
        x = (x + dx * dt).max(0.0);
    }

    x
}

fn main() {
    println!("saturating_at_20={:.5}", saturating_response(20.0, 1.0, 20.0));
    println!("hill_at_60_n4={:.5}", hill_response(60.0, 40.0, 4.0));
    println!("negative_feedback_final={:.5}", negative_feedback_final(180.0, 100.0, 0.18, 0.05, 30.0));
    println!("positive_feedback_final={:.5}", positive_feedback_final(2.0, 3.0, 0.8, 1.5, 4.0, 0.01, 80.0));
}
