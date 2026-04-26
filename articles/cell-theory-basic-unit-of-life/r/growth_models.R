# Cell-growth model workflows in R.

counts_path <- file.path("data", "cell_counts.csv")

if (!file.exists(counts_path)) {
  counts_path <- file.path("..", "data", "cell_counts.csv")
}

counts <- read.csv(counts_path)

fit_condition <- function(df) {
  fit <- lm(log(cells) ~ time_h, data = df)

  r_est <- coef(fit)[["time_h"]]
  n0_est <- exp(coef(fit)[["(Intercept)"]])
  td_est <- log(2) / r_est

  data.frame(
    condition = unique(df$condition),
    growth_rate_per_h = r_est,
    initial_count = n0_est,
    doubling_time_h = td_est,
    r_squared_log_space = summary(fit)$r.squared
  )
}

fit_df <- do.call(
  rbind,
  lapply(split(counts, counts$condition), fit_condition)
)

print(round(fit_df, 5))
