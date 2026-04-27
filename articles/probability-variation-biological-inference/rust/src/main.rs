// Safe probability summary utility in Rust.

fn binomial_summary(successes: f64, trials: f64) -> (f64, f64, f64, f64) {
    let estimate = successes / trials;
    let se = (estimate * (1.0 - estimate) / trials).sqrt();
    let lower = (estimate - 1.96 * se).max(0.0);
    let upper = (estimate + 1.96 * se).min(1.0);
    (estimate, se, lower, upper)
}

fn beta_binomial_update(alpha_prior: f64, beta_prior: f64, successes: f64, trials: f64) -> (f64, f64, f64, f64) {
    let failures = trials - successes;
    let alpha_post = alpha_prior + successes;
    let beta_post = beta_prior + failures;
    let total = alpha_post + beta_post;
    let mean = alpha_post / total;
    let variance = (alpha_post * beta_post) / (total * total * (total + 1.0));
    (alpha_post, beta_post, mean, variance.sqrt())
}

fn binomial_log_likelihood(successes: f64, trials: f64, p: f64) -> f64 {
    if p <= 0.0 || p >= 1.0 {
        return f64::NEG_INFINITY;
    }
    let failures = trials - successes;
    successes * p.ln() + failures * (1.0 - p).ln()
}

fn main() {
    let (estimate, se, lower, upper) = binomial_summary(68.0, 100.0);
    let (alpha_post, beta_post, posterior_mean, posterior_sd) = beta_binomial_update(1.0, 1.0, 68.0, 100.0);

    let mut best_p = 0.0;
    let mut best_ll = f64::NEG_INFINITY;

    for i in 10..=90 {
        let p = i as f64 / 100.0;
        let ll = binomial_log_likelihood(68.0, 100.0, p);
        if ll > best_ll {
            best_ll = ll;
            best_p = p;
        }
    }

    println!("estimate={:.5}", estimate);
    println!("standard_error={:.5}", se);
    println!("ci_lower={:.5}", lower);
    println!("ci_upper={:.5}", upper);
    println!("alpha_posterior={:.3}", alpha_post);
    println!("beta_posterior={:.3}", beta_post);
    println!("posterior_mean={:.5}", posterior_mean);
    println!("posterior_sd={:.5}", posterior_sd);
    println!("best_likelihood_p={:.5}", best_p);
    println!("best_log_likelihood={:.5}", best_ll);
}
