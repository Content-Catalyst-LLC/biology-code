# Justice-adjusted benefit for synthetic biological interventions.

benefits <- read.csv(file.path("data", "justice_benefit.csv"), stringsAsFactors = FALSE)

benefits$justice_adjusted_benefit <- with(
  benefits,
  expected_benefit * (1 - inequality_penalty)
)

benefits <- benefits[order(-benefits$justice_adjusted_benefit), ]

print(round(benefits, 4))
