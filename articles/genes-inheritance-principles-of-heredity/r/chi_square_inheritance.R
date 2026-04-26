# Chi-square goodness-of-fit test for Mendelian ratios.

library(dplyr)

mono_path <- file.path("data", "monohybrid_counts.csv")
di_path <- file.path("data", "dihybrid_counts.csv")

if (!file.exists(mono_path)) {
  mono_path <- file.path("..", "data", "monohybrid_counts.csv")
  di_path <- file.path("..", "data", "dihybrid_counts.csv")
}

run_chi_square <- function(df) {
  total <- sum(df$observed)

  df %>%
    mutate(
      expected = total * expected_ratio,
      chi_component = (observed - expected)^2 / expected
    )
}

mono <- read.csv(mono_path)
di <- read.csv(di_path)

mono_result <- run_chi_square(mono)
di_result <- run_chi_square(di)

print(mono_result)
cat("Monohybrid chi-square =", round(sum(mono_result$chi_component), 4), "\n")

print(di_result)
cat("Dihybrid chi-square =", round(sum(di_result$chi_component), 4), "\n")
