# Fungal condition scoring workflow for restoration ecology.
#
# This illustrative example uses guild richness and soil-context indicators
# to rank sites for fungal condition and recovery monitoring.

library(dplyr)

sites_path <- file.path("data", "fungal_condition_sites.csv")

if (!file.exists(sites_path)) {
  sites_path <- file.path("..", "data", "fungal_condition_sites.csv")
}

fungal_sites <- read.csv(sites_path)

scale01 <- function(x) {
  if (max(x) == min(x)) {
    return(rep(0.5, length(x)))
  }

  (x - min(x)) / (max(x) - min(x))
}

fungal_sites_scored <- fungal_sites %>%
  mutate(
    score_myco = scale01(mycorrhizal_richness),
    score_sapro = scale01(saprotroph_richness),
    score_pathogen = 1 - scale01(pathogen_relative_abundance),
    score_soc = scale01(soil_organic_carbon),
    score_agg = scale01(aggregate_stability),
    fungal_condition_index =
      0.30 * score_myco +
      0.20 * score_sapro +
      0.20 * score_pathogen +
      0.15 * score_soc +
      0.15 * score_agg
  ) %>%
  arrange(desc(fungal_condition_index))

print(round(fungal_sites_scored, 3))
