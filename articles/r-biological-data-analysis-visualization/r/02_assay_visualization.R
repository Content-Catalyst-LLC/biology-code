# Assay visualization.
#
# Run from article directory:
#   Rscript r/02_assay_visualization.R

input_path <- file.path("data", "measurements.csv")
output_path <- file.path("outputs", "figures", "assay_plot.png")

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

measurements <- read.csv(input_path, stringsAsFactors = FALSE)
measurements$value <- suppressWarnings(as.numeric(measurements$value))

plot_data <- measurements[
  measurements$qc_flag == "pass" & !is.na(measurements$value),
]

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)

  plot_obj <- ggplot(plot_data, aes(x = treatment, y = value)) +
    geom_boxplot(outlier.shape = NA, width = 0.5) +
    geom_jitter(width = 0.08, height = 0, alpha = 0.85) +
    labs(
      title = "Biological assay values by treatment",
      x = "Treatment",
      y = paste0("Measurement value (", unique(plot_data$unit), ")")
    ) +
    theme_minimal(base_size = 12)

  ggsave(output_path, plot = plot_obj, width = 7, height = 5, dpi = 300)
  print(plot_obj)
} else {
  png(output_path, width = 1600, height = 1100, res = 220)
  boxplot(
    value ~ treatment,
    data = plot_data,
    main = "Biological assay values by treatment",
    xlab = "Treatment",
    ylab = paste0("Measurement value (", unique(plot_data$unit), ")")
  )
  stripchart(
    value ~ treatment,
    data = plot_data,
    vertical = TRUE,
    method = "jitter",
    pch = 16,
    add = TRUE
  )
  dev.off()
  message("ggplot2 not installed; used base R plotting fallback.")
}

message("Saved figure: ", output_path)
