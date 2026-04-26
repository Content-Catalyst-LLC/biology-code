# Developmental growth workflow in R.
#
# Fits early exponential growth and simulates constrained logistic growth.

library(dplyr)

growth_path <- file.path("data", "developmental_growth.csv")

if (!file.exists(growth_path)) {
  growth_path <- file.path("..", "data", "developmental_growth.csv")
}

growth_df <- read.csv(growth_path)

fit_exp <- lm(log(cells) ~ time_h, data = growth_df %>% slice(1:5))

r_est <- coef(fit_exp)[["time_h"]]
N0_est <- exp(coef(fit_exp)[["(Intercept)"]])
doubling_time_h <- log(2) / r_est

growth_summary <- tibble(
  r_est = r_est,
  N0_est = N0_est,
  doubling_time_h = doubling_time_h
)

print(growth_summary)

growth_df <- growth_df %>%
  mutate(exp_pred = exp(predict(fit_exp, newdata = growth_df)))

print(growth_df)

simulate_logistic <- function(times, N0 = 1e4, r = 0.07, K = 6.2e4) {
  N <- numeric(length(times))
  N[1] <- N0

  for (i in 2:length(times)) {
    dt <- times[i] - times[i - 1]
    dN <- r * N[i - 1] * (1 - N[i - 1] / K)
    N[i] <- N[i - 1] + dN * dt
  }

  tibble(time = times, logistic_N = N)
}

sim_df <- simulate_logistic(seq(0, 40, by = 0.25))

print(sim_df %>% slice_head(n = 12))
print(sim_df %>% slice_tail(n = 12))
