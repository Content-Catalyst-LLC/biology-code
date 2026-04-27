# Equity-adjusted access calculation for synthetic biotechnology interventions.

access <- read.csv(file.path("data", "access_equity.csv"), stringsAsFactors = FALSE)

access$equity_adjusted_access <- with(
  access,
  nominal_availability * (1 - inequality_penalty)
)

access <- access[order(-access$equity_adjusted_access), ]

print(round(access, 4))
