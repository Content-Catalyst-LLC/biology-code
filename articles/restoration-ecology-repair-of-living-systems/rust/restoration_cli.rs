// Restoration CLI in Rust

fn simulate_restoration(s: f64, b_support: f64, disturbance: f64) -> (f64, f64, f64, f64) {
    let a = 0.8;
    let b = 0.15;
    let c = 0.20;
    let p = 0.10;
    let q = 0.25;
    let r = 0.12;
    let u = 0.08;
    let v = 0.10;
    let w = 0.18;
    let dt = 0.05;
    let t_end = 50.0;

    let mut vegetation = 10.0;
    let mut microbial = 8.0;
    let mut function = 6.0;
    let mut peak_function = function;

    let mut time = dt;

    while time <= t_end + 1e-12 {
        let dv = a * s - b * vegetation - c * disturbance;
        let dm = p * vegetation + q * b_support - r * microbial;
        let df = u * vegetation + v * microbial - w * disturbance;

        vegetation = f64::max(0.0, vegetation + dv * dt);
        microbial = f64::max(0.0, microbial + dm * dt);
        function = f64::max(0.0, function + df * dt);

        peak_function = f64::max(peak_function, function);
        time += dt;
    }

    (vegetation, microbial, function, peak_function)
}

fn main() {
    let scenarios = [
        ("low_effort_high_disturbance", 0.7, 0.8, 0.8),
        ("moderate_effort_moderate_disturbance", 1.0, 0.8, 0.5),
        ("high_effort_low_disturbance", 1.4, 0.8, 0.2),
        ("soil_limited_recovery", 1.1, 0.3, 0.4),
    ];

    println!("scenario,final_V,final_M,final_F,peak_F");

    for (name, s, b_support, disturbance) in scenarios {
        let (v, m, f, peak_f) = simulate_restoration(s, b_support, disturbance);
        println!("{},{:.6},{:.6},{:.6},{:.6}", name, v, m, f, peak_f);
    }
}
