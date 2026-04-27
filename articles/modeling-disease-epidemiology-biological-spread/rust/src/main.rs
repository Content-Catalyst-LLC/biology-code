// Safe epidemiology modeling summary utility in Rust.

fn sir_final(population: f64, initial_infected: f64, beta: f64, gamma: f64, dt: f64, steps: usize) -> (f64, f64, f64) {
    let mut susceptible = population - initial_infected;
    let mut infected = initial_infected;
    let mut recovered = 0.0;

    for _ in 0..steps {
        let new_infections = beta * susceptible * infected / population;
        let new_recoveries = gamma * infected;

        susceptible = (susceptible - dt * new_infections).max(0.0);
        infected = (infected + dt * (new_infections - new_recoveries)).max(0.0);
        recovered = (recovered + dt * new_recoveries).min(population);
    }

    (susceptible, infected, recovered)
}

fn main() {
    let (s, i, r) = sir_final(10000.0, 10.0, 0.32, 0.10, 0.25, 240);

    println!("sir_final_susceptible={:.5}", s);
    println!("sir_final_infected={:.5}", i);
    println!("sir_final_recovered={:.5}", r);
}
