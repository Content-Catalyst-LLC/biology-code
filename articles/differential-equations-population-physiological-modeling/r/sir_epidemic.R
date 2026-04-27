# SIR epidemic model.

simulate_sir <- function(beta, gamma, S0, I0, R0, dt = 0.05, t_end = 120) {
  time <- seq(0, t_end, by = dt)
  S <- numeric(length(time))
  I <- numeric(length(time))
  R <- numeric(length(time))

  S[1] <- S0
  I[1] <- I0
  R[1] <- R0

  for (i in 2:length(time)) {
    dS <- -beta * S[i - 1] * I[i - 1]
    dI <- beta * S[i - 1] * I[i - 1] - gamma * I[i - 1]
    dR <- gamma * I[i - 1]

    S[i] <- max(S[i - 1] + dS * dt, 0)
    I[i] <- max(I[i - 1] + dI * dt, 0)
    R[i] <- max(R[i - 1] + dR * dt, 0)
  }

  data.frame(time = time, susceptible = S, infected = I, recovered = R)
}

trajectory <- simulate_sir(0.35, 0.10, 0.99, 0.01, 0)

peak_index <- which.max(trajectory$infected)

summary_df <- data.frame(
  peak_infected = trajectory$infected[peak_index],
  time_to_peak = trajectory$time[peak_index],
  final_recovered = tail(trajectory$recovered, 1)
)

print(round(summary_df, 5))
