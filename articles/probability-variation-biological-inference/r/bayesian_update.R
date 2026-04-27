# Beta-binomial Bayesian updating workflow in R.

prior_path <- file.path("data", "bayesian_priors.csv")
if (!file.exists(prior_path)) {
  prior_path <- file.path("..", "data", "bayesian_priors.csv")
}

priors <- read.csv(prior_path)

priors$failures <- priors$trials - priors$successes
priors$alpha_posterior <- priors$alpha_prior + priors$successes
priors$beta_posterior <- priors$beta_prior + priors$failures
priors$posterior_mean <- priors$alpha_posterior / (priors$alpha_posterior + priors$beta_posterior)
priors$posterior_sd <- sqrt(
  (priors$alpha_posterior * priors$beta_posterior) /
  ((priors$alpha_posterior + priors$beta_posterior)^2 *
   (priors$alpha_posterior + priors$beta_posterior + 1))
)

print(round(priors, 5))
