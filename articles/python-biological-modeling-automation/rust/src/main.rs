// Safe biological modeling summary utility in Rust.

fn logistic_growth(initial: f64, growth_rate: f64, carrying_capacity: f64, dt: f64, steps: usize) -> f64 {
    let mut population = initial;

    for _ in 0..steps {
        let growth = growth_rate * population * (1.0 - population / carrying_capacity);
        population = (population + dt * growth).max(0.0);
    }

    population
}

fn two_compartment(initial_a: f64, initial_b: f64, k_ab: f64, k_ba: f64, k_clear: f64, dt: f64, steps: usize) -> (f64, f64, f64) {
    let mut amount_a = initial_a;
    let mut amount_b = initial_b;

    for _ in 0..steps {
        let flow_ab = k_ab * amount_a;
        let flow_ba = k_ba * amount_b;
        let clearance = k_clear * amount_a;

        let next_a = (amount_a + dt * (-flow_ab + flow_ba - clearance)).max(0.0);
        let next_b = (amount_b + dt * (flow_ab - flow_ba)).max(0.0);

        amount_a = next_a;
        amount_b = next_b;
    }

    (amount_a, amount_b, amount_a + amount_b)
}

fn main() {
    let final_population = logistic_growth(25.0, 0.35, 1000.0, 0.1, 200);
    let (a, b, total) = two_compartment(100.0, 0.0, 0.18, 0.07, 0.03, 0.1, 150);

    println!("final_population={:.5}", final_population);
    println!("final_compartment_a={:.5}", a);
    println!("final_compartment_b={:.5}", b);
    println!("final_total_amount={:.5}", total);
}
