# Cross-check parameter validation in R.

rules <- read.csv(file.path("data", "parameter_rules.csv"), stringsAsFactors = FALSE)
logistic <- read.csv(file.path("data", "logistic_parameters.csv"), stringsAsFactors = FALSE)

rows <- list()

for (parameter in intersect(names(logistic), rules$parameter)) {
  rule <- rules[rules$parameter == parameter, ]

  for (i in seq_len(nrow(logistic))) {
    value <- as.numeric(logistic[i, parameter])
    passed <- value >= rule$lower_bound & value <= rule$upper_bound

    rows[[length(rows) + 1]] <- data.frame(
      table_name = "logistic_parameters.csv",
      row_index = i - 1,
      parameter = parameter,
      value = value,
      lower_bound = rule$lower_bound,
      upper_bound = rule$upper_bound,
      passed = passed
    )
  }
}

report <- do.call(rbind, rows)

print(report)
