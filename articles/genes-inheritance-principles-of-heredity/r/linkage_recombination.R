# Linked loci and recombination in R.
#
# Simulates gametes from a coupling-phase heterozygote AB/ab.

library(dplyr)

set.seed(42)

recomb_path <- file.path("data", "recombination_observations.csv")

if (!file.exists(recomb_path)) {
  recomb_path <- file.path("..", "data", "recombination_observations.csv")
}

observed <- read.csv(recomb_path)

observed_r <- observed %>%
  summarise(
    total = sum(count),
    recombinant = sum(count[class == "recombinant"]),
    recombination_fraction = recombinant / total
  )

print(observed_r)

r <- 0.18

gametes <- sample(
  c("AB", "ab", "Ab", "aB"),
  size = 20000,
  replace = TRUE,
  prob = c((1 - r) / 2, (1 - r) / 2, r / 2, r / 2)
)

freq <- prop.table(table(gametes))
print(round(freq, 4))

estimated_recombination_fraction <- freq["Ab"] + freq["aB"]

cat(
  "Estimated recombination fraction =",
  round(estimated_recombination_fraction, 4),
  "\n"
)
