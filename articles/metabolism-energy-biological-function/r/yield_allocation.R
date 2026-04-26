# Biomass yield and allocation workflow in R.

substrate_path <- file.path("data", "substrate_biomass.csv")
energy_path <- file.path("data", "energy_budget.csv")

if (!file.exists(substrate_path)) {
  substrate_path <- file.path("..", "data", "substrate_biomass.csv")
  energy_path <- file.path("..", "data", "energy_budget.csv")
}

substrate_df <- read.csv(substrate_path)

substrate_df$delta_biomass_g_L <- substrate_df$biomass_final_g_L - substrate_df$biomass_initial_g_L
substrate_df$Yxs_g_g <- substrate_df$delta_biomass_g_L / substrate_df$substrate_consumed_g_L
substrate_df$product_fraction <- substrate_df$product_g_L / substrate_df$substrate_consumed_g_L
substrate_df$maintenance_fraction <- substrate_df$maintenance_estimate_g_L / substrate_df$substrate_consumed_g_L

print(round(substrate_df, 4))

energy_df <- read.csv(energy_path)

allocation_cols <- c(
  "substrate_to_growth",
  "substrate_to_maintenance",
  "substrate_to_product",
  "substrate_loss"
)

for (col in allocation_cols) {
  energy_df[[paste0(col, "_fraction")]] <- energy_df[[col]] / energy_df$substrate_input
}

energy_df$mass_balance_residual <- energy_df$substrate_input - rowSums(energy_df[, allocation_cols])

print(round(energy_df, 4))
