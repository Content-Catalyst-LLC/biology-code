# Evolutionary mismatch score cross-check.

exposures <- read.csv(file.path("data", "mismatch_exposures.csv"), stringsAsFactors = FALSE)

exposures$mismatch_distance <- abs(
  exposures$current_exposure - exposures$adapted_exposure_reference
)

exposures$weighted_mismatch_score <- with(
  exposures,
  mismatch_distance * evidence_confidence
)

exposures <- exposures[order(-exposures$weighted_mismatch_score), ]

print(round(exposures, 4))
