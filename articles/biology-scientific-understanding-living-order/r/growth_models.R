# Growth models for living order in R.

growth_path <- file.path("data", "growth_observations.csv")
logistic_path <- file.path("data", "logistic_scenarios.csv")

if (!file.exists(growth_path)) {
  growth_path <- file.path("..", "data", "growth_observations.csv")
  logistic_path <- file.path("..", "data", "logistic_scenarios.csv")
}

growth <- read.csv(growth_path)

fit_condition <- function(df) {
  fit <- lm(log(abundance) ~ time, data = df)

  r_est <- coef(fit)[["time"]]
  n0_est <- exp(coef(fit)[["(Intercept)"]])
  td_est <- log(2) / r_est

  data.frame(
    condition = unique(df$condition),
    growth_rate = r_est,
    initial_abundance = n0_est,
    doubling_time = td_est,
    r_squared_log_space = summary(fit)$r.squared
  )
}

fit_df <- do.call(
  rbind,
  lapply(split(growth, growth$condition), fit_condition)
)

print(round(fit_df, 5))

logistic_growth <- function(time, initial_abundance, growth_rate, carrying_capacity) {
  carrying_capacity /
    (1 + ((carrying_capacity - initial_abundance) / initial_abundance) *
      exp(-growth_rate * time))
}

scenarios <- read.csv(logistic_path)

rows <- lapply(seq_len(nrow(scenarios)), function(i) {
  s <- scenarios[i, ]
  time <- seq(0, s$time_end, by = s$dt)

  trajectory <- logistic_growth(
    time,
    s$initial_abundance,
    s$growth_rate,
    s$carrying_capacity
  )

  data.frame(
    scenario = s$scenario,
    final_abundance = tail(trajectory, 1),
    fraction_of_capacity = tail(trajectory, 1) / s$carrying_capacity
  )
})

summary_df <- do.call(rbind, rows)

print(round(summary_df, 5))
