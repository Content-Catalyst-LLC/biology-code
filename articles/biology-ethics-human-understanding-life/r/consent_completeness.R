# Consent-completeness indicators for synthetic biology ethics scenarios.

consent <- read.csv(file.path("data", "consent_records.csv"), stringsAsFactors = FALSE)

consent$consent_completeness <- with(
  consent,
  elements_understood / elements_required
)

consent$review_flag <- with(
  consent,
  consent_completeness < 0.75 | plain_language_available == FALSE | withdrawal_explained == FALSE
)

consent <- consent[order(consent$consent_completeness), ]

print(consent)
