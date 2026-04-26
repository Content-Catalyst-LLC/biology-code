// Hardy-Weinberg and allele-frequency utility in Rust.

fn hardy_weinberg(p: f64) -> (f64, f64, f64) {
    let q = 1.0 - p;
    (p * p, 2.0 * p * q, q * q)
}

fn selection_update(p: f64, w_aa_capital: f64, w_heterozygote: f64, w_aa_lower: f64) -> f64 {
    let q = 1.0 - p;
    let wbar = p * p * w_aa_capital + 2.0 * p * q * w_heterozygote + q * q * w_aa_lower;
    (p * p * w_aa_capital + p * q * w_heterozygote) / wbar
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

    let mut p = 0.5;

    for generation in 0..=10 {
        println!("generation={} p={:.6}", generation, p);
        p = selection_update(p, 1.10, 1.05, 1.00);
    }
}
