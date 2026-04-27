# Simple somatic evolution clonal expansion scenario.

scenarios <- read.csv(file.path("data", "somatic_evolution_scenarios.csv"), stringsAsFactors = FALSE)

rows <- data.frame()

for (i in seq_len(nrow(scenarios))) {
  scenario <- scenarios[i, ]
  time <- 0:scenario$time_steps
  clone_size <- scenario$initial_clone_size * exp(scenario$growth_rate * time)

  rows <- rbind(
    rows,
    data.frame(
      clone_id = scenario$clone_id,
      time = time,
      clone_size = clone_size,
      selection_context = scenario$selection_context
    )
  )
}

summary <- rows[ave(rows$time, rows$clone_id, FUN = max) == rows$time, ]

print(round(summary, 2))
