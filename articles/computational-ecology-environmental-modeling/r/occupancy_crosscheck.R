# Patch occupancy cross-check in R.

simulate_patch_occupancy <- function(initial_occupancy, colonization, extinction, steps) {
  occupancy <- initial_occupancy
  rows <- data.frame(step = integer(), occupancy = numeric())

  for (step in 0:steps) {
    rows <- rbind(rows, data.frame(step = step, occupancy = occupancy))
    occupancy <- occupancy * (1 - extinction) + (1 - occupancy) * colonization
    occupancy <- min(max(occupancy, 0), 1)
  }

  rows
}

baseline <- simulate_patch_occupancy(
  initial_occupancy = 0.42,
  colonization = 0.12,
  extinction = 0.08,
  steps = 30
)

print(round(tail(baseline), 5))
