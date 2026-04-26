# Mutation supply and mutation spectrum workflow in R.

library(dplyr)

spectrum_path <- file.path("data", "mutation_spectrum.csv")

if (!file.exists(spectrum_path)) {
  spectrum_path <- file.path("..", "data", "mutation_spectrum.csv")
}

mu <- 1e-8
L <- 1.2e8
n_genomes <- 500

lambda <- n_genomes * L * mu

k_vals <- 0:15

pois_df <- tibble(
  k = k_vals,
  probability = dpois(k_vals, lambda = lambda)
)

print(tibble(expected_mutations_lambda = lambda))
print(pois_df)

mutations <- read.csv(spectrum_path) %>%
  mutate(
    fraction = count / sum(count)
  ) %>%
  arrange(desc(fraction))

print(mutations)
