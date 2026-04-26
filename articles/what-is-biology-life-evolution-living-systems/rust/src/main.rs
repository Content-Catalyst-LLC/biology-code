// Biology foundations utility in Rust.

fn hardy_weinberg(p: f64) -> (f64, f64, f64) {
    let q = 1.0 - p;
    (p * p, 2.0 * p * q, q * q)
}

fn shannon(counts: &[f64]) -> f64 {
    let total: f64 = counts.iter().sum();
    let mut h = 0.0;

    for count in counts {
        if *count > 0.0 {
            let p = count / total;
            h -= p * p.ln();
        }
    }

    h
}

fn main() {
    let cases = vec![0.70, 0.50, 0.25, 0.90];

    for p in cases {
        let (aa_capital, heterozygote, aa_lower) = hardy_weinberg(p);
        println!(
            "p={:.3} AA={:.3} Aa={:.3} aa={:.3}",
            p, aa_capital, heterozygote, aa_lower
        );
    }

    let counts = vec![25.0, 18.0, 11.0, 6.0, 4.0];
    println!("shannon_diversity={:.6}", shannon(&counts));
}
