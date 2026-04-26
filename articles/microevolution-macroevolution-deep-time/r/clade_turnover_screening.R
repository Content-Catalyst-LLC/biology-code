# Macroevolutionary turnover screening in R.

library(dplyr)

clade_path <- file.path("data", "clade_turnover.csv")

if (!file.exists(clade_path)) {
  clade_path <- file.path("..", "data", "clade_turnover.csv")
}

clades <- read.csv(clade_path) %>%
  mutate(
    lambda = originations / interval_myr,
    mu = extinctions / interval_myr,
    net_diversification = lambda - mu,
    turnover = lambda + mu,
    clade_state = case_when(
      net_diversification > 0 ~ "expanding",
      net_diversification == 0 ~ "balanced",
      TRUE ~ "declining"
    )
  ) %>%
  arrange(desc(net_diversification))

print(clades)
