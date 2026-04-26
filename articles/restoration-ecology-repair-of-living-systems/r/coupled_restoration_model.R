# Coupled Restoration Model in R
#
# This script models restoration as coupled recovery of:
# - vegetation structure (V)
# - soil or microbial recovery (M)
# - functional integrity (F)

library(tidyverse)

article_dir <- "articles/restoration-ecology-repair-of-living-systems"

params <- read_csv(
  file.path(article_dir, "data/restoration_parameters.csv"),
  show_col_types = FALSE
)

get_param <- function(name) {
  params %>%
    filter(parameter == name) %>%
    pull(value) %>%
    as.numeric()
}

a <- get_param("a")
b <- get_param("b")
c <- get_param("c")
p <- get_param("p")
q <- get_param("q")
r <- get_param("r")
u <- get_param("u")
v <- get_param("v")
w <- get_param("w")
dt <- get_param("dt")
T_end <- get_param("T")

S <- 1.0
B <- 0.8
D <- 0.5

time <- seq(0, T_end, by = dt)

V <- numeric(length(time))
M <- numeric(length(time))
F <- numeric(length(time))

V[1] <- 10
M[1] <- 8
F[1] <- 6

for (i in 2:length(time)) {
  dV <- a * S - b * V[i - 1] - c * D
  dM <- p * V[i - 1] + q * B - r * M[i - 1]
  dF <- u * V[i - 1] + v * M[i - 1] - w * D

  V[i] <- max(0, V[i - 1] + dV * dt)
  M[i] <- max(0, M[i - 1] + dM * dt)
  F[i] <- max(0, F[i - 1] + dF * dt)
}

trajectory <- tibble(
  time = time,
  vegetation_structure = V,
  soil_microbial_recovery = M,
  functional_integrity = F
)

summary <- trajectory %>%
  summarise(
    final_vegetation_structure = last(vegetation_structure),
    final_soil_microbial_recovery = last(soil_microbial_recovery),
    final_functional_integrity = last(functional_integrity),
    peak_functional_integrity = max(functional_integrity)
  )

write_csv(
  trajectory,
  file.path(article_dir, "data/computed_coupled_restoration_trajectory_r.csv")
)

write_csv(
  summary,
  file.path(article_dir, "data/computed_coupled_restoration_summary_r.csv")
)

print(summary)
