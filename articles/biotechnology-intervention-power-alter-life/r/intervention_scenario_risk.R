# Intervention scenario risk scoring for synthetic biotechnology release scenarios.

scenarios <- read.csv(file.path("data", "ecological_release_scenarios.csv"), stringsAsFactors = FALSE)

scenarios$risk_score <- with(scenarios, exposure * magnitude * uncertainty)
scenarios$governance_buffer <- with(scenarios, monitoring_capacity * reversibility)
scenarios$net_concern_score <- with(scenarios, risk_score * (1 - governance_buffer))

scenarios <- scenarios[order(-scenarios$net_concern_score), ]

print(round(scenarios, 4))
