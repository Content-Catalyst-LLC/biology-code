# Binomial confidence interval workflow in R.

trial_path <- file.path("data", "binomial_trials.csv")
if (!file.exists(trial_path)) {
  trial_path <- file.path("..", "data", "binomial_trials.csv")
}

trials <- read.csv(trial_path)

rows <- list()

for (i in seq_len(nrow(trials))) {
  x <- trials$successes[i]
  n <- trials$trials[i]
  estimate <- x / n
  se <- sqrt(estimate * (1 - estimate) / n)
  exact_ci <- binom.test(x, n)$conf.int

  rows[[i]] <- data.frame(
    experiment = trials$experiment[i],
    context = trials$context[i],
    successes = x,
    trials = n,
    estimate = estimate,
    standard_error = se,
    normal_ci_lower = max(estimate - 1.96 * se, 0),
    normal_ci_upper = min(estimate + 1.96 * se, 1),
    exact_ci_lower = exact_ci[1],
    exact_ci_upper = exact_ci[2]
  )
}

summary_df <- do.call(rbind, rows)

print(round(summary_df, 5))
