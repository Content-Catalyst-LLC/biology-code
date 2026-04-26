# Monohybrid and dihybrid inheritance simulation in R.

set.seed(42)

gamete <- function(genotype) {
  sample(strsplit(genotype, "")[[1]], 1)
}

offspring_mono <- replicate(10000, {
  paste(sort(c(gamete("Aa"), gamete("Aa"))), collapse = "")
})

mono_result <- prop.table(table(offspring_mono))
print(round(mono_result, 4))

gametes_dihybrid <- c("AB", "Ab", "aB", "ab")

offspring_di <- replicate(10000, {
  g1 <- sample(gametes_dihybrid, 1)
  g2 <- sample(gametes_dihybrid, 1)

  A_present <- grepl("A", g1) | grepl("A", g2)
  B_present <- grepl("B", g1) | grepl("B", g2)

  if (A_present & B_present) {
    "A_B_"
  } else if (A_present & !B_present) {
    "A_bb"
  } else if (!A_present & B_present) {
    "aaB_"
  } else {
    "aabb"
  }
})

di_result <- prop.table(table(offspring_di))
print(round(di_result, 4))
