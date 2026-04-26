# Treatment-response summary in R.

counts_path <- file.path("data", "cell_counts.csv")
viability_path <- file.path("data", "viability_observations.csv")

if (!file.exists(counts_path)) {
  counts_path <- file.path("..", "data", "cell_counts.csv")
  viability_path <- file.path("..", "data", "viability_observations.csv")
}

counts <- read.csv(counts_path)
viability <- read.csv(viability_path)

growth_summary <- do.call(
  rbind,
  lapply(split(counts, counts$condition), function(df) {
    fit <- lm(log(cells) ~ time_h, data = df)
    r <- coef(fit)[["time_h"]]

    data.frame(
      condition = unique(df$condition),
      growth_rate_per_h = r,
      doubling_time_h = log(2) / r
    )
  })
)

viability_summary <- do.call(
  rbind,
  lapply(split(viability, viability$condition), function(df) {
    fit <- lm(log(viable_cells) ~ time_h, data = df)
    k <- -coef(fit)[["time_h"]]

    data.frame(
      condition = unique(df$condition),
      loss_rate_per_h = k,
      viability_half_life_h = log(2) / k
    )
  })
)

print(round(growth_summary, 5))
print(round(viability_summary, 5))
