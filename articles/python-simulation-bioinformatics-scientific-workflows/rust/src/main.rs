// Safe biological simulation and sequence summary utility in Rust.

fn logistic_growth(initial: f64, growth_rate: f64, carrying_capacity: f64, dt: f64, steps: usize) -> Vec<f64> {
    let mut population = initial;
    let mut trajectory = Vec::new();

    for _ in 0..=steps {
        trajectory.push(population);
        let growth = growth_rate * population * (1.0 - population / carrying_capacity);
        population = (population + dt * growth).max(0.0);
    }

    trajectory
}

fn gc_content(sequence: &str) -> f64 {
    let mut valid = 0.0;
    let mut gc = 0.0;

    for base in sequence.chars().map(|c| c.to_ascii_uppercase()) {
        match base {
            'A' | 'T' => valid += 1.0,
            'G' | 'C' => {
                valid += 1.0;
                gc += 1.0;
            }
            _ => {}
        }
    }

    if valid == 0.0 {
        f64::NAN
    } else {
        gc / valid
    }
}

fn main() {
    let trajectory = logistic_growth(25.0, 0.35, 1000.0, 0.1, 200);
    let sequence = "ATGCGCGTAATTAACCGGTTACCGTAGCTA";

    println!("final_population={:.5}", trajectory.last().unwrap());
    println!("gc_content={:.5}", gc_content(sequence));
}
