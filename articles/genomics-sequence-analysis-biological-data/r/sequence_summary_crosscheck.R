# Sequence summary cross-check in R.

fasta_path <- file.path("data", "sequences.fasta")
lines <- readLines(fasta_path)

records <- list()
current_id <- NULL
current_sequence <- ""

for (line in lines) {
  if (startsWith(line, ">")) {
    if (!is.null(current_id)) {
      records[[current_id]] <- toupper(current_sequence)
    }
    current_id <- strsplit(sub("^>", "", line), " ")[[1]][1]
    current_sequence <- ""
  } else {
    current_sequence <- paste0(current_sequence, line)
  }
}

if (!is.null(current_id)) {
  records[[current_id]] <- toupper(current_sequence)
}

gc_content <- function(sequence) {
  bases <- strsplit(sequence, "")[[1]]
  valid <- bases[bases %in% c("A", "C", "G", "T")]

  if (length(valid) == 0) return(NA_real_)

  sum(valid %in% c("G", "C")) / length(valid)
}

summary_table <- data.frame(
  sequence_id = names(records),
  length = sapply(records, nchar),
  gc_content = sapply(records, gc_content),
  ambiguous_bases = sapply(records, function(sequence) {
    bases <- strsplit(sequence, "")[[1]]
    sum(!(bases %in% c("A", "C", "G", "T")))
  }),
  row.names = NULL
)

print(round(summary_table, 5))
