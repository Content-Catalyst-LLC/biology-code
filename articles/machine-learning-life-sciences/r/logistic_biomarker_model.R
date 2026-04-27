# Transparent logistic model for synthetic life-science biomarker classification.

samples <- read.csv(file.path("data", "biological_samples.csv"), stringsAsFactors = FALSE)
features <- read.csv(file.path("data", "biomarker_features.csv"), stringsAsFactors = FALSE)

data <- merge(samples, features, by = "sample_id")
data$label <- ifelse(data$condition == "case", 1, 0)

model <- glm(
  label ~ immune_score + metabolic_score + morphology_score + stress_response_score,
  data = data,
  family = binomial()
)

data$predicted_probability <- predict(model, type = "response")
data$predicted_label <- ifelse(data$predicted_probability >= 0.5, 1, 0)

accuracy <- mean(data$predicted_label == data$label)

print(summary(model))
print(data[, c("sample_id", "condition", "predicted_probability", "predicted_label")])
print(paste("Apparent accuracy:", round(accuracy, 3)))
