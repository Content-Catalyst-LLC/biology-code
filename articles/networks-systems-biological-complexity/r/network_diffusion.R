# Simple diffusion on a biological network.

nodes <- c("A", "B", "C", "D", "E", "F")

adjacency <- matrix(
  c(
    0, 1, 1, 0, 0, 0,
    1, 0, 1, 1, 0, 0,
    1, 1, 0, 0, 1, 0,
    0, 1, 0, 0, 1, 1,
    0, 0, 1, 1, 0, 1,
    0, 0, 0, 1, 1, 0
  ),
  nrow = 6,
  byrow = TRUE
)

state <- c(1, 0, 0, 0, 0, 0)
alpha <- 0.12
decay <- 0.05
steps <- 20

history <- matrix(NA, nrow = steps + 1, ncol = length(nodes))
history[1, ] <- state

for (step in 1:steps) {
  state <- state + alpha * as.vector(adjacency %*% state) - decay * state
  state <- pmax(state, 0)
  history[step + 1, ] <- state
}

trajectory <- data.frame(step = 0:steps, history)
names(trajectory) <- c("step", nodes)

print(round(tail(trajectory, 5), 5))
