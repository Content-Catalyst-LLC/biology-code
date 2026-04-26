# Feedback-inhibited pathway flux workflow in R.

pathway_path <- file.path("data", "pathway_steps.csv")

if (!file.exists(pathway_path)) {
  pathway_path <- file.path("..", "data", "pathway_steps.csv")
}

pathway <- read.csv(pathway_path)
pathway$effective_capacity <- pathway$capacity * pathway$regulation_factor

estimated_flux <- min(pathway$effective_capacity)
bottleneck <- pathway[which.min(pathway$effective_capacity), ]

print(round(pathway, 3))
cat("Estimated pathway flux =", round(estimated_flux, 3), "\n")
print(bottleneck)

substrate <- seq(0.1, 30, length.out = 200)
product <- seq(0, 20, length.out = 200)

Vmax <- 120
Km <- 5
Kf <- 6

base_velocity <- (Vmax * substrate) / (Km + substrate)
feedback_factor <- 1 / (1 + product / Kf)
feedback_velocity <- base_velocity * feedback_factor

flux_df <- data.frame(
  substrate = substrate,
  product = product,
  base_velocity = base_velocity,
  feedback_factor = feedback_factor,
  feedback_velocity = feedback_velocity
)

print(head(round(flux_df, 4), 12))
print(tail(round(flux_df, 4), 12))
