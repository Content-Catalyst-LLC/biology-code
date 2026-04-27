# Chemostat biomass-substrate model.

monod_growth <- function(substrate, mu_max, K_s) {
  mu_max * substrate / (K_s + substrate)
}

simulate_chemostat <- function(X0, S0, S_in, D, Y, mu_max, K_s, dt = 0.01, t_end = 80) {
  time <- seq(0, t_end, by = dt)
  X <- numeric(length(time))
  S <- numeric(length(time))

  X[1] <- X0
  S[1] <- S0

  for (i in 2:length(time)) {
    mu <- monod_growth(S[i - 1], mu_max, K_s)

    dX <- mu * X[i - 1] - D * X[i - 1]
    dS <- D * (S_in - S[i - 1]) - (1 / Y) * mu * X[i - 1]

    X[i] <- max(X[i - 1] + dX * dt, 0)
    S[i] <- max(S[i - 1] + dS * dt, 0)
  }

  data.frame(time = time, biomass = X, substrate = S)
}

trajectory <- simulate_chemostat(0.1, 10, 20, 0.20, 0.50, 0.80, 2.0)

summary_df <- data.frame(
  final_biomass = tail(trajectory$biomass, 1),
  final_substrate = tail(trajectory$substrate, 1),
  max_biomass = max(trajectory$biomass),
  min_substrate = min(trajectory$substrate)
)

print(round(summary_df, 5))
