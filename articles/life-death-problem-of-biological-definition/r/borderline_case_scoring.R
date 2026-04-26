# Borderline life-criteria matrix in R.

cases_path <- file.path("data", "borderline_cases.csv")
weights_path <- file.path("data", "life_criteria_weights.csv")

if (!file.exists(cases_path)) {
  cases_path <- file.path("..", "data", "borderline_cases.csv")
  weights_path <- file.path("..", "data", "life_criteria_weights.csv")
}

cases <- read.csv(cases_path)
weights_df <- read.csv(weights_path)

weights <- setNames(weights_df$weight, weights_df$criterion)

cases$heuristic_life_score <-
  cases$organization * weights[["organization"]] +
  cases$metabolism * weights[["metabolism"]] +
  cases$autonomy * weights[["autonomy"]] +
  cases$heredity * weights[["heredity"]] +
  cases$responsiveness * weights[["responsiveness"]] +
  cases$evolutionary_capacity * weights[["evolutionary_capacity"]]

cases$category <- ifelse(
  cases$heuristic_life_score >= 0.72,
  "strongly_life_like_under_this_matrix",
  ifelse(
    cases$heuristic_life_score >= 0.45,
    "borderline_or_context_dependent",
    "weakly_life_like_under_this_matrix"
  )
)

cases <- cases[order(-cases$heuristic_life_score), ]

print(round(cases, 3))
