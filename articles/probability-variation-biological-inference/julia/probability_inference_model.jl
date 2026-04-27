# Probability and biological inference kernels in Julia.

function binomial_summary(successes, trials)
    estimate = successes / trials
    se = sqrt(estimate * (1 - estimate) / trials)
    return estimate, se, max(estimate - 1.96 * se, 0.0), min(estimate + 1.96 * se, 1.0)
end

function beta_binomial_update(alpha_prior, beta_prior, successes, trials)
    alpha_post = alpha_prior + successes
    beta_post = beta_prior + trials - successes
    posterior_mean = alpha_post / (alpha_post + beta_post)
    posterior_variance = (alpha_post * beta_post) / ((alpha_post + beta_post)^2 * (alpha_post + beta_post + 1))
    return alpha_post, beta_post, posterior_mean, sqrt(posterior_variance)
end

function binomial_log_likelihood(successes, trials, p)
    if p <= 0 || p >= 1
        return -Inf
    end
    failures = trials - successes
    return successes * log(p) + failures * log(1 - p)
end

estimate, se, lower, upper = binomial_summary(68, 100)
println("estimate=", round(estimate, digits=5), " se=", round(se, digits=5), " ci=(", round(lower, digits=5), ", ", round(upper, digits=5), ")")

alpha_post, beta_post, post_mean, post_sd = beta_binomial_update(1, 1, 68, 100)
println("posterior alpha=", alpha_post, " beta=", beta_post, " mean=", round(post_mean, digits=5), " sd=", round(post_sd, digits=5))

best_p = 0.0
best_ll = -Inf

for p in range(0.1, 0.9, length=81)
    ll = binomial_log_likelihood(68, 100, p)
    if ll > best_ll
        best_ll = ll
        best_p = p
    end
end

println("best_probability=", round(best_p, digits=5), " best_log_likelihood=", round(best_ll, digits=5))
