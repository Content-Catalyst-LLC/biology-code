// Safe biodiversity metrics utility in Rust.
//
// This example avoids external crates so it can compile with a minimal
// Rust toolchain. It calculates Shannon diversity and Hill q=1.

fn shannon_diversity(counts: &[f64]) -> f64 {
    let total: f64 = counts.iter().sum();

    if total <= 0.0 {
        return 0.0;
    }

    counts
        .iter()
        .filter(|&&count| count > 0.0)
        .map(|&count| {
            let p = count / total;
            -p * p.ln()
        })
        .sum()
}

fn richness(counts: &[f64]) -> usize {
    counts.iter().filter(|&&count| count > 0.0).count()
}

fn main() {
    let site_a = vec![12.0, 8.0, 0.0, 5.0, 3.0];

    let shannon = shannon_diversity(&site_a);
    let hill_q1 = shannon.exp();

    println!("richness={}", richness(&site_a));
    println!("shannon={:.3}", shannon);
    println!("hill_q1={:.3}", hill_q1);
}
