# Biostatistical models for biological response data.
#
# Run from article directory:
#   Rscript r/01_biostatistics_models.R

input_path <- file.path("data", "biostat_measurements.csv")
output_path <- file.path("outputs", "tables", "biostatistics_model_summary.csv")

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

data <- read.csv(input_path, stringsAsFactors = FALSE)
data$response <- as.numeric(data$response)
data$binary_response <- as.integer(data$binary_response)

analysis_data <- data[data$qc_flag == "pass", ]

linear_model <- lm(response ~ treatment + batch, data = analysis_data)
logistic_model <- glm(binary_response ~ response, data = analysis_data, family = binomial())

linear_coefficients <- data.frame(
  model = "linear_model_response_treatment_batch",
  term = names(coef(linear_model)),
  estimate = as.numeric(coef(linear_model)),
  row.names = NULL
)

logistic_coefficients <- data.frame(
  model = "logistic_model_binary_response",
  term = names(coef(logistic_model)),
  estimate = as.numeric(coef(logistic_model)),
  row.names = NULL
)

summary_table <- rbind(linear_coefficients, logistic_coefficients)

if (requireNamespace("lme4", quietly = TRUE)) {
  mixed_model <- lme4::lmer(response ~ treatment + (1 | batch), data = analysis_data)
  mixed_row <- data.frame(
    model = "optional_mixed_model_response_treatment_batch_random_intercept",
    term = "treatmenttreated",
    estimate = as.numeric(lme4::fixef(mixed_model)["treatmenttreated"]),
    row.names = NULL
  )
  summary_table <- rbind(summary_table, mixed_row)
} else {
  message("Optional package lme4 not installed; mixed-model scaffold skipped.")
}

if (requireNamespace("survival", quietly = TRUE)) {
  surv_object <- survival::Surv(time = analysis_data$time, event = analysis_data$event)
  cox_model <- survival::coxph(surv_object ~ treatment, data = analysis_data)
  cox_row <- data.frame(
    model = "optional_cox_survival_model",
    term = names(coef(cox_model)),
    estimate = as.numeric(coef(cox_model)),
    row.names = NULL
  )
  summary_table <- rbind(summary_table, cox_row)
} else {
  message("Optional package survival not installed; survival-analysis scaffold skipped.")
}

write.csv(summary_table, output_path, row.names = FALSE)

print(summary(linear_model))
print(summary(logistic_model))
print(summary_table)
