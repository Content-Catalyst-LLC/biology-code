// Safe biological network summary utility in Rust.

fn degree(adjacency: &[Vec<f64>]) -> Vec<usize> {
    adjacency
        .iter()
        .map(|row| row.iter().filter(|&&value| value > 0.0).count())
        .collect()
}

fn density(adjacency: &[Vec<f64>]) -> f64 {
    let n = adjacency.len();
    let mut edges = 0.0;

    for i in 0..n {
        for j in (i + 1)..n {
            if adjacency[i][j] > 0.0 {
                edges += 1.0;
            }
        }
    }

    let possible = (n * (n - 1)) as f64 / 2.0;
    edges / possible
}

fn diffuse(adjacency: &[Vec<f64>], initial: &[f64], alpha: f64, decay: f64, steps: usize) -> Vec<f64> {
    let n = initial.len();
    let mut state = initial.to_vec();

    for _ in 0..steps {
        let mut next = vec![0.0; n];

        for i in 0..n {
            next[i] = state[i] - decay * state[i];

            for j in 0..n {
                next[i] += alpha * adjacency[i][j] * state[j];
            }

            if next[i] < 0.0 {
                next[i] = 0.0;
            }
        }

        state = next;
    }

    state
}

fn main() {
    let adjacency = vec![
        vec![0.0, 1.0, 0.8, 0.0, 0.0, 0.0],
        vec![1.0, 0.0, 0.7, 1.2, 0.0, 0.0],
        vec![0.8, 0.7, 0.0, 0.0, 0.9, 0.0],
        vec![0.0, 1.2, 0.0, 0.0, 1.1, 0.6],
        vec![0.0, 0.0, 0.9, 1.1, 0.0, 0.5],
        vec![0.0, 0.0, 0.0, 0.6, 0.5, 0.0],
    ];

    let degrees = degree(&adjacency);
    let final_state = diffuse(&adjacency, &[1.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.08, 0.04, 20);

    println!("density={:.5}", density(&adjacency));
    println!("mean_degree={:.5}", degrees.iter().sum::<usize>() as f64 / degrees.len() as f64);
    println!("max_degree={}", degrees.iter().max().unwrap());
    println!("final_state={:?}", final_state);
}
