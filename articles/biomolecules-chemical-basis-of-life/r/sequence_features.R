# DNA and protein sequence-feature extraction in R.

sequence_path <- file.path("data", "sequences.csv")

if (!file.exists(sequence_path)) {
  sequence_path <- file.path("..", "data", "sequences.csv")
}

records <- read.csv(sequence_path)

gc_content <- function(sequence) {
  chars <- strsplit(sequence, split = "")[[1]]
  counts <- table(chars)
  g <- ifelse("G" %in% names(counts), counts[["G"]], 0)
  c <- ifelse("C" %in% names(counts), counts[["C"]], 0)
  (g + c) / length(chars)
}

protein_features <- function(sequence) {
  chars <- strsplit(sequence, split = "")[[1]]
  hydrophobic <- c("A", "I", "L", "M", "F", "W", "Y", "V")
  charged <- c("D", "E", "K", "R", "H")

  data.frame(
    length = length(chars),
    hydrophobic_fraction = sum(chars %in% hydrophobic) / length(chars),
    charged_fraction = sum(chars %in% charged) / length(chars)
  )
}

rows <- list()

for (i in seq_len(nrow(records))) {
  seq_type <- tolower(records$sequence_type[i])
  seq_value <- records$sequence[i]

  if (seq_type == "dna") {
    rows[[i]] <- data.frame(
      sequence_id = records$sequence_id[i],
      sequence_type = "DNA",
      length = nchar(seq_value),
      gc_content = gc_content(seq_value),
      hydrophobic_fraction = NA,
      charged_fraction = NA
    )
  } else if (seq_type == "protein") {
    features <- protein_features(seq_value)
    rows[[i]] <- data.frame(
      sequence_id = records$sequence_id[i],
      sequence_type = "protein",
      length = features$length,
      gc_content = NA,
      hydrophobic_fraction = features$hydrophobic_fraction,
      charged_fraction = features$charged_fraction
    )
  }
}

summary_df <- do.call(rbind, rows)
print(round(summary_df, 4))
