# One-compartment pharmacokinetic model.

simulate_one_compartment <- function(C0, elimination_rate, dt = 0.05, t_end = 48) {
  time <- seq(0, t_end, by = dt)
  C <- numeric(length(time))
  C[1] <- C0

  for (i in 2:length(time)) {
    dC <- -elimination_rate * C[i - 1]
    C[i] <- max(C[i - 1] + dC * dt, 0)
  }

  data.frame(time = time, concentration = C)
}

trajectory <- simulate_one_compartment(20, 0.12)

summary_df <- data.frame(
  initial_concentration = trajectory$concentration[1],
  final_concentration = tail(trajectory$concentration, 1),
  half_life = log(2) / 0.12
)

print(round(summary_df, 5))
