# Osmotic pressure workflow in R.

solute_path <- file.path("data", "solute_conditions.csv")

if (!file.exists(solute_path)) {
  solute_path <- file.path("..", "data", "solute_conditions.csv")
}

solute <- read.csv(solute_path)

R_gas <- 0.082057

solute$osmotic_pressure_atm <-
  solute$van_t_hoff_factor *
  solute$concentration_mol_L *
  R_gas *
  solute$temperature_K

solute$relative_water_stress <-
  solute$osmotic_pressure_atm / max(solute$osmotic_pressure_atm)

print(round(solute, 5))
