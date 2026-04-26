# Morphogen-gradient workflow in R.
#
# Simple positional-information model with threshold-based cell fates.

library(dplyr)

morphogen_path <- file.path("data", "morphogen_gradient.csv")

if (!file.exists(morphogen_path)) {
  morphogen_path <- file.path("..", "data", "morphogen_gradient.csv")
}

fate_df <- read.csv(morphogen_path) %>%
  mutate(
    fate = case_when(
      morphogen > 0.60 ~ "fate_A",
      morphogen > 0.25 ~ "fate_B",
      TRUE ~ "fate_C"
    )
  )

print(fate_df)
print(fate_df %>% count(fate))
