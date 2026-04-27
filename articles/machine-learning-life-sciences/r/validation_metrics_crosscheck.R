# Validation metric cross-check for synthetic external validation data.

validation <- read.csv(file.path("data", "external_validation_samples.csv"), stringsAsFactors = FALSE)

# A transparent scoring rule is used here for R-only cross-checking.
validation$predicted_probability <- with(
  validation,
  plogis(3.0 * immune_score - 2.0 * metabolic_score + 2.2 * morphology_score + 1.2 * stress_response_score - 2.0)
)

validation$predicted_label <- ifelse(validation$predicted_probability >= 0.5, 1, 0)

tp <- sum(validation$observed_condition == 1 & validation$predicted_label == 1)
tn <- sum(validation$observed_condition == 0 & validation$predicted_label == 0)
fp <- sum(validation$observed_condition == 0 & validation$predicted_label == 1)
fn <- sum(validation$observed_condition == 1 & validation$predicted_label == 0)

accuracy <- (tp + tn) / nrow(validation)
sensitivity <- ifelse((tp + fn) > 0, tp / (tp + fn), NA)
specificity <- ifelse((tn + fp) > 0, tn / (tn + fp), NA)

metrics <- data.frame(
  metric = c("accuracy", "sensitivity", "specificity", "true_positive", "true_negative", "false_positive", "false_negative"),
  value = c(accuracy, sensitivity, specificity, tp, tn, fp, fn)
)

print(round(metrics, 5))
