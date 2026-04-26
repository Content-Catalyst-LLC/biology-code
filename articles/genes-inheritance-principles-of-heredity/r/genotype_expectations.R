# Basic population-genetic expectations in R.
#
# Computes genotype frequencies and expected heterozygosity.

p <- 0.7
q <- 1 - p

genotype_df <- data.frame(
  genotype = c("AA", "Aa", "aa"),
  expected_frequency = c(p^2, 2 * p * q, q^2)
)

expected_heterozygosity <- 2 * p * q

print(genotype_df)
cat("Expected heterozygosity =", round(expected_heterozygosity, 4), "\n")
