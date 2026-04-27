# Host-burden scoring for synthetic biology constructs.

burden <- read.csv(file.path("data", "host_burden.csv"), stringsAsFactors = FALSE)

burden$burden_score <- ifelse(
  burden$growth_rate_control == 0,
  0,
  1 - burden$growth_rate_engineered / burden$growth_rate_control
)

burden <- burden[order(burden$burden_score), ]

print(round(burden, 4))
