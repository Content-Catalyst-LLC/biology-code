# Survivorship and extinction proportions across clades in R.

library(dplyr)

clade_path <- file.path("data", "clade_survivorship.csv")

if (!file.exists(clade_path)) {
  clade_path <- file.path("..", "data", "clade_survivorship.csv")
}

clades <- read.csv(clade_path) %>%
  mutate(
    survivorship = survivors / initial,
    extinction = 1 - survivorship,
    loss_count = initial - survivors
  ) %>%
  arrange(desc(extinction))

print(clades)
