// Safe dynamic biological model summary utility in Rust.

fn logistic_final(n0: f64, r: f64, k: f64, dt: f64, t_end: f64) -> f64 {
    let steps = (t_end / dt).floor() as usize + 1;
    let mut n = n0;

    for _ in 1..steps {
        let dn = r * n * (1.0 - n / k);
        n = (n + dn * dt).max(0.0);
    }

    n
}

fn homeostasis_final(x0: f64, set_point: f64, k: f64, dt: f64, t_end: f64) -> f64 {
    let steps = (t_end / dt).floor() as usize + 1;
    let mut x = x0;

    for _ in 1..steps {
        let dx = -k * (x - set_point);
        x += dx * dt;
    }

    x
}

fn pk_final(c0: f64, elimination_rate: f64, dt: f64, t_end: f64) -> f64 {
    let steps = (t_end / dt).floor() as usize + 1;
    let mut c = c0;

    for _ in 1..steps {
        let dc = -elimination_rate * c;
        c = (c + dc * dt).max(0.0);
    }

    c
}

fn main() {
    println!("logistic_final={:.5}", logistic_final(100.0, 0.30, 2000.0, 0.05, 40.0));
    println!("homeostasis_final={:.5}", homeostasis_final(180.0, 100.0, 0.18, 0.05, 30.0));
    println!("pk_final={:.5}", pk_final(20.0, 0.12, 0.05, 48.0));
}
