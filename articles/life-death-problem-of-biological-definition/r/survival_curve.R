# Survival curve in R.

time_h <- seq(0, 96, by = 0.5)
hazard_rate <- 0.0289
initial_viable_count <- 1.0e6

survival_probability <- exp(-hazard_rate * time_h)
viable_count <- initial_viable_count * survival_probability

survival_df <- data.frame(
  time_h = time_h,
  survival_probability = survival_probability,
  viable_count = viable_count
)

print(head(round(survival_df, 5), 12))
print(tail(round(survival_df, 5), 12))
