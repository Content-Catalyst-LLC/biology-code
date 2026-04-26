# Biomolecular composition analysis in R.

composition_path <- file.path("data", "biomolecule_composition.csv")
elemental_path <- file.path("data", "elemental_composition.csv")

if (!file.exists(composition_path)) {
  composition_path <- file.path("..", "data", "biomolecule_composition.csv")
  elemental_path <- file.path("..", "data", "elemental_composition.csv")
}

composition <- read.csv(composition_path)

biomolecule_columns <- c(
  "carbohydrate_mg",
  "lipid_mg",
  "protein_mg",
  "nucleic_acid_mg",
  "metabolite_mg"
)

composition$total_biomolecule_mg <- rowSums(composition[, biomolecule_columns])

for (col in biomolecule_columns) {
  fraction_col <- sub("_mg", "_fraction", col)
  composition[[fraction_col]] <- composition[[col]] / composition$total_biomolecule_mg
}

print(round(composition, 4))

elements <- read.csv(elemental_path)

elements$C_to_N <- elements$carbon_mmol / elements$nitrogen_mmol
elements$C_to_P <- elements$carbon_mmol / elements$phosphorus_mmol
elements$N_to_P <- elements$nitrogen_mmol / elements$phosphorus_mmol

print(round(elements, 4))
