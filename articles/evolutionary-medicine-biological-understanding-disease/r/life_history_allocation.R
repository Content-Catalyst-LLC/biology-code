# Life-history allocation trade-off summary.

allocation <- read.csv(file.path("data", "life_history_allocation.csv"), stringsAsFactors = FALSE)

allocation$total_allocation <- with(
  allocation,
  growth + reproduction + maintenance + immune_defense
)

allocation$maintenance_risk_index <- 1 - allocation$maintenance
allocation$inflammation_pressure_index <- with(
  allocation,
  immune_defense * (1 - maintenance)
)

allocation <- allocation[order(-allocation$maintenance_risk_index), ]

print(round(allocation, 4))
