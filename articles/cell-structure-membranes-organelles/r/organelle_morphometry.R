# Organelle morphometry summary in R.

morph_path <- file.path("data", "organelle_morphometry.csv")

if (!file.exists(morph_path)) {
  morph_path <- file.path("..", "data", "organelle_morphometry.csv")
}

morph <- read.csv(morph_path)

morph$mitochondrial_fraction <- morph$mitochondrial_area_um2 / morph$cell_area_um2
morph$er_fraction <- morph$er_area_um2 / morph$cell_area_um2
morph$golgi_fraction <- morph$golgi_area_um2 / morph$cell_area_um2
morph$nucleus_fraction <- morph$nucleus_area_um2 / morph$cell_area_um2
morph$lysosome_density <- morph$lysosome_count / morph$cell_area_um2

print(round(morph, 4))

summary_df <- aggregate(
  cbind(
    mitochondrial_fraction,
    er_fraction,
    golgi_fraction,
    nucleus_fraction,
    lysosome_density
  ) ~ condition,
  data = morph,
  FUN = mean
)

print(round(summary_df, 4))
