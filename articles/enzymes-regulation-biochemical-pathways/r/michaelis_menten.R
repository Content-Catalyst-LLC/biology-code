# Michaelis-Menten kinetics in R.

substrate <- seq(0.1, 30, length.out = 300)

Vmax <- 120
Km <- 5

velocity <- (Vmax * substrate) / (Km + substrate)

kinetics_df <- data.frame(
  substrate_mM = substrate,
  velocity_units_min = velocity,
  fraction_vmax = velocity / Vmax
)

print(head(round(kinetics_df, 4), 12))
print(tail(round(kinetics_df, 4), 12))

half_max_row <- kinetics_df[which.min(abs(kinetics_df$velocity_units_min - Vmax / 2)), ]
print(round(half_max_row, 4))
