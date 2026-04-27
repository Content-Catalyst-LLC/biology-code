# Metabolic product-yield table for synthetic biology pathway runs.

runs <- read.csv(file.path("data", "metabolic_runs.csv"), stringsAsFactors = FALSE)

runs$product_yield <- with(
  runs,
  product_formed_g_l / substrate_consumed_g_l
)

runs <- runs[order(-runs$product_yield), ]

print(round(runs, 4))
