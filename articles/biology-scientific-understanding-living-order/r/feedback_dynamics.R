# Feedback dynamics in R.

feedback_path <- file.path("data", "feedback_scenarios.csv")

if (!file.exists(feedback_path)) {
  feedback_path <- file.path("..", "data", "feedback_scenarios.csv")
}

feedback <- read.csv(feedback_path)

feedback$deviation <- feedback$state - feedback$setpoint
feedback$corrective_response <- feedback$feedback_gain * (feedback$setpoint - feedback$state)
feedback$absolute_response <- abs(feedback$corrective_response)

print(round(feedback, 5))
