# Simplified diet-diversity scoring for synthetic households.

diet <- read.csv(file.path("data", "diet_diversity.csv"), stringsAsFactors = FALSE)

food_groups <- c("grains", "legumes", "fruits", "vegetables", "animal_source", "nuts_seeds", "dairy")

diet$diet_diversity_score <- rowSums(diet[, food_groups])
diet$low_diversity_flag <- diet$diet_diversity_score < 4

diet <- diet[order(-diet$diet_diversity_score), ]

print(diet)
