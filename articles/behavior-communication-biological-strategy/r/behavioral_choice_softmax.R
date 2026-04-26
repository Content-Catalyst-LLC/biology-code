# Behavioral choice model in R.
#
# This script compares behavioral options under baseline and high-predation
# conditions using a weighted utility function and softmax probabilities.

softmax <- function(x, beta = 1) {
  ex <- exp(beta * (x - max(x)))
  ex / sum(ex)
}

options_path <- file.path("data", "behavioral_options.csv")

if (!file.exists(options_path)) {
  options_path <- file.path("..", "data", "behavioral_options.csv")
}

behavior_options <- read.csv(options_path)

behavior_options$utility <- with(
  behavior_options,
  benefit - 0.8 * energetic_cost - 1.2 * predation_risk
)

behavior_options$choice_probability <- softmax(
  behavior_options$utility,
  beta = 1.1
)

behavior_options$utility_high_risk <- with(
  behavior_options,
  benefit - 0.8 * energetic_cost - 1.8 * predation_risk
)

behavior_options$choice_probability_high_risk <- softmax(
  behavior_options$utility_high_risk,
  beta = 1.1
)

print(round(behavior_options, 3))
