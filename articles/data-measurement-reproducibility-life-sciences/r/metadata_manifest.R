# Metadata manifest workflow.

dict_path <- file.path("data", "data_dictionary.csv")
artifact_path <- file.path("data", "artifact_manifest.csv")

if (!file.exists(dict_path)) {
  dict_path <- file.path("..", "data", "data_dictionary.csv")
  artifact_path <- file.path("..", "data", "artifact_manifest.csv")
}

dictionary <- read.csv(dict_path)
artifacts <- read.csv(artifact_path)

dictionary_summary <- data.frame(
  n_variables = nrow(dictionary),
  n_required = sum(tolower(dictionary$required) == "true"),
  n_with_units = sum(dictionary$unit != "")
)

artifact_summary <- aggregate(
  artifact_name ~ artifact_role,
  data = artifacts,
  FUN = length
)

names(artifact_summary)[names(artifact_summary) == "artifact_name"] <- "n_artifacts"

print(dictionary_summary)
print(artifact_summary)
