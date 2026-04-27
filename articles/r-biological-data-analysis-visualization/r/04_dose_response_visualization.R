# Descriptive dose-response visualization.
#
# Run from article directory:
#   Rscript r/04_dose_response_visualization.R

input_path <- file.path("data", "dose_response.csv")
output_path <- file.path("outputs", "figures", "dose_response_plot.png")

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

dose_data <- read.csv(input_path, stringsAsFactors = FALSE)
dose_data$dose <- suppressWarnings(as.numeric(dose_data$dose))
dose_data$response <- suppressWarnings(as.numeric(dose_data$response))

plot_data <- dose_data[
  dose_data$qc_flag == "pass" & !is.na(dose_data$dose) & !is.na(dose_data$response),
]

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  plot_obj <- ggplot(plot_data, aes(x = dose, y = response)) +
    geom_point(alpha = 0.85) +
    geom_smooth(method = "loess", se = TRUE) +
    scale_x_continuous(trans = "log10") +
    labs(
      title = "Descriptive dose-response pattern",
      x = "Dose",
      y = "Response"
    ) +
    theme_minimal(base_size = 12)

  ggsave(output_path, plot = plot_obj, width = 7, height = 5, dpi = 300)
  print(plot_obj)
} else {
  png(output_path, width = 1600, height = 1100, res = 220)
  plot(
    plot_data$dose,
    plot_data$response,
    log = "x",
    pch = 16,
    xlab = "Dose",
    ylab = "Response",
    main = "Descriptive dose-response pattern"
  )
  lines(
    lowess(plot_data$dose, plot_data$response),
    lwd = 2
  )
  dev.off()
  message("ggplot2 not installed; used base R plotting fallback.")
}

message("Saved figure: ", output_path)
