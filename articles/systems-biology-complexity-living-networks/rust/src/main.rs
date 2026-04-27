// Safe systems-biology summary utility in Rust.

fn simulate_feedback(
    x0: f64,
    y0: f64,
    production_x: f64,
    production_y: f64,
    degradation_x: f64,
    degradation_y: f64,
    hill_n: f64,
    dt: f64,
    steps: usize,
) -> (f64, f64) {
    let mut x = x0;
    let mut y = y0;

    for _ in 0..steps {
        let dx = production_x / (1.0 + y.powf(hill_n)) - degradation_x * x;
        let dy = production_y * x - degradation_y * y;

        x = (x + dt * dx).max(0.0);
        y = (y + dt * dy).max(0.0);
    }

    (x, y)
}

fn main() {
    let (x, y) = simulate_feedback(0.20, 0.10, 1.20, 0.80, 0.40, 0.30, 2.0, 0.10, 80);

    println!("final_x={:.5}", x);
    println!("final_y={:.5}", y);
}
