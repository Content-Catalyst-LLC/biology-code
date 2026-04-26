# Coupled physiological regulation model in R.
#
# This compact workflow models:
# - regulated variable X
# - hormonal controller H
# - effector response E
# - uptake or correction as a function of H and X
#
# Euler integration is used for article-scale clarity.

dt <- 0.05
time <- seq(0, 40, by = dt)

# Parameters
X_star <- 5
I_in <- 0.6
a <- 0.9
b <- 0.5
c <- 0.7
d <- 0.4
u0 <- 0.3
u1 <- 0.25

# State variables
X <- numeric(length(time))
H <- numeric(length(time))
E <- numeric(length(time))

# Initial condition: perturbed internal variable
X[1] <- 10
H[1] <- 0
E[1] <- 0

for (t in 2:length(time)) {
  uptake <- u0 + u1 * H[t - 1] * X[t - 1]

  dX <- I_in - uptake
  dH <- a * (X[t - 1] - X_star) - b * H[t - 1]
  dE <- c * H[t - 1] - d * E[t - 1]

  X[t] <- max(0, X[t - 1] + dX * dt)
  H[t] <- max(0, H[t - 1] + dH * dt)
  E[t] <- max(0, E[t - 1] + dE * dt)
}

results <- data.frame(
  time = time,
  regulated_variable = X,
  hormonal_signal = H,
  effector_response = E
)

print(tail(round(results, 3), 10))

diagnostics <- data.frame(
  peak_X = max(X),
  peak_H = max(H),
  peak_E = max(E),
  final_X = tail(X, 1),
  recovery_error = abs(tail(X, 1) - X_star)
)

print(round(diagnostics, 3))
