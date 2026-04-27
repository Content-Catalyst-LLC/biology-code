# Reproducibility manifest.
#
# Run from article directory:
#   Rscript r/05_reproducibility_manifest.R

input_path <- file.path("data", "provenance_manifest.csv")
output_path <- file.path("outputs", "tables", "artifact_manifest.csv")

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

provenance <- read.csv(input_path, stringsAsFactors = FALSE)

artifact_manifest <- data.frame(
  artifact = unique(c(provenance$input_artifact, provenance$output_artifact, provenance$script)),
  role = c(
    rep("input_or_output", length(unique(c(provenance$input_artifact, provenance$output_artifact)))),
    rep("code", length(unique(provenance$script)))
  )[seq_along(unique(c(provenance$input_artifact, provenance$output_artifact, provenance$script)))],
  status = "tracked",
  generated_by = "r/05_reproducibility_manifest.R",
  stringsAsFactors = FALSE
)

write.csv(artifact_manifest, output_path, row.names = FALSE)

print(artifact_manifest)
print(sessionInfo())
