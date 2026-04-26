# Expression kinetics workflow in R.
#
# Fits exponential decay and simulates production-decay dynamics.

library(dplyr)

expr_path <- file.path("data", "expression_timecourse.csv")

if (!file.exists(expr_path)) {
  expr_path <- file.path("..", "data", "expression_timecourse.csv")
}

decay_df <- read.csv(expr_path)

fit <- lm(log(expression) ~ time_h, data = decay_df)

k_est <- -coef(fit)[["time_h"]]
m0_est <- exp(coef(fit)[["(Intercept)"]])
half_life_h <- log(2) / k_est

decay_summary <- tibble(
  k_est = k_est,
  m0_est = m0_est,
  half_life_h = half_life_h
)

print(decay_summary)

decay_df <- decay_df %>%
  mutate(pred_expression = exp(predict(fit)))

print(decay_df)

simulate_prod_decay <- function(
  times,
  alpha_base = 2,
  alpha_pulse = 18,
  pulse_start = 3,
  pulse_end = 8,
  beta = 0.35,
  m0 = 5
) {
  m <- numeric(length(times))
  m[1] <- m0

  for (i in 2:length(times)) {
    dt <- times[i] - times[i - 1]
    alpha_t <- ifelse(
      times[i - 1] >= pulse_start & times[i - 1] <= pulse_end,
      alpha_pulse,
      alpha_base
    )

    dm <- alpha_t - beta * m[i - 1]
    m[i] <- max(m[i - 1] + dm * dt, 0)
  }

  tibble(time = times, expression = m)
}

times <- seq(0, 20, by = 0.1)
sim_df <- simulate_prod_decay(times)

print(sim_df %>% slice_head(n = 12))
print(sim_df %>% slice_tail(n = 12))
