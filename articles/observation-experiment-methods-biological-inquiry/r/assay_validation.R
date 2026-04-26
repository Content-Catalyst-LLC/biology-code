# Assay-validation metrics in R.

assay_path <- file.path("data", "assay_validation.csv")
if (!file.exists(assay_path)) {
  assay_path <- file.path("..", "data", "assay_validation.csv")
}

assay <- read.csv(assay_path)

assay$sensitivity <- assay$true_positive / (assay$true_positive + assay$false_negative)
assay$specificity <- assay$true_negative / (assay$true_negative + assay$false_positive)
assay$positive_predictive_value <- assay$true_positive / (assay$true_positive + assay$false_positive)
assay$negative_predictive_value <- assay$true_negative / (assay$true_negative + assay$false_negative)
assay$accuracy <- (assay$true_positive + assay$true_negative) /
  (assay$true_positive + assay$false_negative + assay$true_negative + assay$false_positive)

print(round(assay, 4))
