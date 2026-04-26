# Competitive and noncompetitive inhibition models in R.

substrate <- seq(0.1, 30, length.out = 300)

Vmax <- 120
Km <- 5
inhibitor <- 4
Ki <- 2

v_control <- (Vmax * substrate) / (Km + substrate)

v_competitive <- (Vmax * substrate) /
  (Km * (1 + inhibitor / Ki) + substrate)

v_noncompetitive <- (Vmax / (1 + inhibitor / Ki)) *
  substrate / (Km + substrate)

kinetics_df <- data.frame(
  substrate = substrate,
  control = v_control,
  competitive = v_competitive,
  noncompetitive = v_noncompetitive
)

print(head(round(kinetics_df, 4), 12))
print(tail(round(kinetics_df, 4), 12))
