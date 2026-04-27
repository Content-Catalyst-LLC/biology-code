# Ecological risk and reversibility indicators for synthetic biology ethics scenarios.

risk <- read.csv(file.path("data", "ecological_risk.csv"), stringsAsFactors = FALSE)

risk$ecological_risk <- with(
  risk,
  exposure_probability * harm_magnitude * uncertainty
)

risk$reversibility_adjusted_risk <- with(
  risk,
  ecological_risk * (1 - reversibility)
)

risk$monitoring_gap <- 1 - risk$monitoring_capacity

risk <- risk[order(-risk$reversibility_adjusted_risk), ]

print(round(risk, 4))
