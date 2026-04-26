# Quantitative trait selection and breeder's equation response in R.

library(dplyr)

set.seed(42)

n <- 2000
trait <- rnorm(n, mean = 0, sd = 1)

fitness <- exp(0.6 * trait)
fitness <- fitness / mean(fitness)

population <- tibble(
  trait = trait,
  relative_fitness = fitness
)

mean_trait_before <- mean(population$trait)
selected_mean <- weighted.mean(population$trait, w = population$relative_fitness)
selection_differential <- selected_mean - mean_trait_before

heritability <- 0.45
response_to_selection <- heritability * selection_differential
predicted_next_mean <- mean_trait_before + response_to_selection

summary_tbl <- tibble(
  mean_before_selection = mean_trait_before,
  selected_weighted_mean = selected_mean,
  selection_differential_S = selection_differential,
  heritability_h2 = heritability,
  response_R = response_to_selection,
  predicted_next_generation_mean = predicted_next_mean
)

print(summary_tbl)
