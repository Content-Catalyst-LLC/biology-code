# Nutrient use efficiency for synthetic production systems.

systems <- read.csv(file.path("data", "production_systems.csv"), stringsAsFactors = FALSE)

systems$nutrient_use_efficiency <- with(
  systems,
  nutrient_harvested_kg / nutrient_input_kg
)

systems <- systems[order(-systems$nutrient_use_efficiency), ]

print(round(systems[, c("system", "nutrient_input_kg", "nutrient_harvested_kg", "nutrient_use_efficiency")], 4))
