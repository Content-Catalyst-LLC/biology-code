# Network degree cross-check in R.

edges <- read.csv(file.path("data", "interactions.csv"), stringsAsFactors = FALSE)

all_nodes <- c(edges$source, edges$target)
degree_table <- as.data.frame(table(all_nodes))
names(degree_table) <- c("node_id", "degree")

degree_table <- degree_table[order(-degree_table$degree), ]

print(degree_table)
