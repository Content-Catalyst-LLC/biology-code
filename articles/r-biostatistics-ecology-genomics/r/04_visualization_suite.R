# Visualization suite for biostatistics, ecology, and genomics.
#
# Run from article directory:
#   Rscript r/04_visualization_suite.R

biostat_path <- file.path("data", "biostat_measurements.csv")
ecology_output_path <- file.path("outputs", "tables", "ecology_diversity_ordination.csv")
genomics_output_path <- file.path("outputs", "tables", "genomics_count_summary.csv")
figure_path <- file.path("outputs", "figures", "r_biology_workflow_panels.png")

dir.create(dirname(figure_path), recursive = TRUE, showWarnings = FALSE)

biostat <- read.csv(biostat_path, stringsAsFactors = FALSE)
biostat$response <- as.numeric(biostat$response)
biostat <- biostat[biostat$qc_flag == "pass", ]

if (!file.exists(ecology_output_path)) {
  source(file.path("r", "02_ecology_diversity_ordination.R"), local = TRUE)
}

if (!file.exists(genomics_output_path)) {
  source(file.path("r", "03_genomics_count_workflow.R"), local = TRUE)
}

ecology <- read.csv(ecology_output_path, stringsAsFactors = FALSE)
genomics <- read.csv(genomics_output_path, stringsAsFactors = FALSE)

png(figure_path, width = 1800, height = 1200, res = 220)
par(mfrow = c(2, 2), mar = c(5, 5, 4, 2))

boxplot(
  response ~ treatment,
  data = biostat,
  main = "Biostatistical response",
  xlab = "Treatment",
  ylab = "Response"
)
stripchart(
  response ~ treatment,
  data = biostat,
  vertical = TRUE,
  method = "jitter",
  pch = 16,
  add = TRUE
)

plot(
  ecology$axis_1,
  ecology$axis_2,
  pch = 16,
  xlab = "Ordination axis 1",
  ylab = "Ordination axis 2",
  main = "Ecological ordination scaffold"
)

barplot(
  ecology$shannon,
  names.arg = ecology$site,
  main = "Shannon diversity",
  xlab = "Site",
  ylab = "H'"
)

barplot(
  genomics$log2_fold_change,
  names.arg = genomics$gene_id,
  main = "Genomics log2 fold change",
  xlab = "Gene",
  ylab = "log2 fold change",
  las = 2
)

dev.off()

message("Saved figure: ", figure_path)
