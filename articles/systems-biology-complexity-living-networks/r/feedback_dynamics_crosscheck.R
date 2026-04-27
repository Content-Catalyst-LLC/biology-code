# Feedback dynamics cross-check in R.

simulate_feedback <- function(x0, y0, production_x, production_y, degradation_x, degradation_y, hill_n, dt, steps) {
  x <- x0
  y <- y0
  rows <- data.frame(step = integer(), time = numeric(), x = numeric(), y = numeric())

  for (step in 0:steps) {
    rows <- rbind(rows, data.frame(step = step, time = step * dt, x = x, y = y))

    dx <- production_x / (1 + y^hill_n) - degradation_x * x
    dy <- production_y * x - degradation_y * y

    x <- max(x + dt * dx, 0)
    y <- max(y + dt * dy, 0)
  }

  rows
}

trajectory <- simulate_feedback(
  x0 = 0.20,
  y0 = 0.10,
  production_x = 1.20,
  production_y = 0.80,
  degradation_x = 0.40,
  degradation_y = 0.30,
  hill_n = 2.0,
  dt = 0.10,
  steps = 80
)

print(round(tail(trajectory), 5))
