# Quorum-sensing signal accumulation workflow in R.

times <- seq(0, 24, by = 0.1)

N <- 1e5 * exp(0.25 * times)
N <- pmin(N, 1e9)

Q <- numeric(length(times))

a <- 1e-9
d <- 0.35
Qc <- 1.0

for (i in 2:length(times)) {
  dt <- times[i] - times[i - 1]
  dQ <- a * N[i - 1] - d * Q[i - 1]
  Q[i] <- max(Q[i - 1] + dQ * dt, 0)
}

quorum_df <- data.frame(
  time = times,
  population_density = N,
  quorum_signal = Q,
  response_active = Q >= Qc
)

print(head(round(quorum_df, 4), 10))
print(round(quorum_df[which(quorum_df$response_active)[1], ], 4))
