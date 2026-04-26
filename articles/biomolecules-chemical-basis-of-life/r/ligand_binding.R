# Ligand-binding workflow in R.

binding_path <- file.path("data", "ligand_binding.csv")

if (!file.exists(binding_path)) {
  binding_path <- file.path("..", "data", "ligand_binding.csv")
}

binding <- read.csv(binding_path)

binding$fraction_bound <- binding$ligand_uM / (binding$Kd_uM + binding$ligand_uM)
binding$fraction_unbound <- 1 - binding$fraction_bound

print(round(binding, 5))

ligand <- seq(0.1, 50, length.out = 300)
Kd <- 8

binding_curve <- data.frame(
  ligand = ligand,
  fraction_bound = ligand / (Kd + ligand)
)

print(head(round(binding_curve, 5), 12))
print(tail(round(binding_curve, 5), 12))
