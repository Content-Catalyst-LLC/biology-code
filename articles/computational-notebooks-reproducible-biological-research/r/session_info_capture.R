# Capture R session information for reproducible biological notebooks.

dir.create(file.path("outputs"), showWarnings = FALSE)
dir.create(file.path("outputs", "reports"), recursive = TRUE, showWarnings = FALSE)

session_information <- capture.output(sessionInfo())

writeLines(
  session_information,
  con = file.path("outputs", "reports", "r_session_info.txt")
)

cat("Session information written to outputs/reports/r_session_info.txt\n")
