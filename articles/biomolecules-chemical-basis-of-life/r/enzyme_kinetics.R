# Michaelis-Menten kinetics in R.

assay_path <- file.path("data", "enzyme_assays.csv")

if (!file.exists(assay_path)) {
  assay_path <- file.path("..", "data", "enzyme_assays.csv")
}

assays <- read.csv(assay_path)

assays$velocity <- (assays$Vmax * assays$substrate_mM) /
  (assays$Km + assays$substrate_mM)

assays$fraction_vmax <- assays$velocity / assays$Vmax

print(round(assays, 5))

substrate <- seq(0.1, 30, length.out = 300)
Vmax <- 100
Km <- 3

curve <- data.frame(
  substrate = substrate,
  velocity = (Vmax * substrate) / (Km + substrate)
)

print(head(round(curve, 5), 12))
print(tail(round(curve, 5), 12))
