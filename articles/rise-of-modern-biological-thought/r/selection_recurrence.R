# Selection recurrence workflow in R.

selection_path <- file.path("data", "selection_scenarios.csv")
if (!file.exists(selection_path)) {
  selection_path <- file.path("..", "data", "selection_scenarios.csv")
}

selection_update <- function(p, w_AA, w_Aa, w_aa) {
  q <- 1 - p
  wbar <- p^2 * w_AA + 2 * p * q * w_Aa + q^2 * w_aa
  (p^2 * w_AA + p * q * w_Aa) / wbar
}

scenarios <- read.csv(selection_path)

rows <- list()

for (i in seq_len(nrow(scenarios))) {
  s <- scenarios[i, ]
  p <- s$p_initial

  for (generation in 0:s$generations) {
    rows[[length(rows) + 1]] <- data.frame(
      scenario = s$scenario,
      generation = generation,
      p = p
    )

    p <- selection_update(p, s$w_AA, s$w_Aa, s$w_aa)
  }
}

df <- do.call(rbind, rows)

final_df <- do.call(
  rbind,
  lapply(split(df, df$scenario), function(x) x[which.max(x$generation), ])
)

print(round(final_df, 5))
