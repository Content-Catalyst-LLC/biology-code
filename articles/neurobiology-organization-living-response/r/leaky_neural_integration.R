# Leaky neural integration with repeated inputs in R.
#
# This script models a membrane-like state variable moving toward rest
# under repeated input pulses and records simplified threshold events.

dt <- 0.1
time <- seq(0, 40, by = dt)

tau <- 3
V_rest <- -65
R <- 1
threshold <- -60

I <- rep(0, length(time))
I[time >= 5 & time < 8] <- 8
I[time >= 15 & time < 17] <- 5
I[time >= 28 & time < 31] <- 10

V <- numeric(length(time))
V[1] <- V_rest

for (t in 2:length(time)) {
  dV <- (-(V[t - 1] - V_rest) + R * I[t - 1]) / tau
  V[t] <- V[t - 1] + dV * dt
}

events <- ifelse(V >= threshold, 1, 0)

results <- data.frame(
  time = time,
  input = I,
  voltage_state = V,
  threshold_event = events
)

print(head(round(results, 3), 20))

diagnostics <- data.frame(
  max_voltage = max(V),
  event_count = sum(events),
  final_voltage = tail(V, 1)
)

print(round(diagnostics, 3))
