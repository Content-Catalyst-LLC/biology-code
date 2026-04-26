# Biological levels summary in R.

levels_path <- file.path("data", "biological_levels.csv")
if (!file.exists(levels_path)) {
  levels_path <- file.path("..", "data", "biological_levels.csv")
}

levels <- read.csv(levels_path)

print(levels)
