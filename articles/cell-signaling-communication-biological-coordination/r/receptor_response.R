# Receptor occupancy and Hill response workflow in R.

receptor_path <- file.path("data", "receptor_response.csv")

if (!file.exists(receptor_path)) {
  receptor_path <- file.path("..", "data", "receptor_response.csv")
}

observed <- read.csv(receptor_path)

Kd <- 1.5
K <- 2.0
n <- 3.0

observed$occupancy <- observed$ligand / (Kd + observed$ligand)
observed$hill_response <- observed$ligand^n / (K^n + observed$ligand^n)
observed$residual_observed_minus_hill <- observed$observed_response - observed$hill_response

print(round(observed, 4))

threshold_row <- observed[which.min(abs(observed$hill_response - 0.5)), ]
print(round(threshold_row, 4))
