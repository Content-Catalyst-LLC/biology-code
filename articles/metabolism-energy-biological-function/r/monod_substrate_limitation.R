# Monod-style substrate-limited growth in R.

substrate <- seq(0, 20, length.out = 200)

mu_max <- 0.08
Ks <- 2.5

mu <- mu_max * substrate / (Ks + substrate)

monod_df <- data.frame(
  substrate_mM = substrate,
  growth_rate_per_h = mu,
  fraction_mu_max = mu / mu_max
)

half_sat_row <- monod_df[which.min(abs(monod_df$growth_rate_per_h - mu_max / 2)), ]

print(head(round(monod_df, 5), 12))
print(tail(round(monod_df, 5), 12))
print(round(half_sat_row, 5))
