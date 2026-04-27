# Ecological food-web summary.

data_path <- file.path("data", "food_web_edges.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "food_web_edges.csv")
}

edges <- read.csv(data_path)

nodes <- sort(unique(c(edges$source, edges$target)))

degree_summary <- data.frame(
  node = nodes,
  degree = sapply(nodes, function(node) {
    sum(edges$source == node | edges$target == node)
  })
)

network_summary <- data.frame(
  n_nodes = length(nodes),
  n_edges = nrow(edges),
  density = (2 * nrow(edges)) / (length(nodes) * (length(nodes) - 1)),
  mean_degree = mean(degree_summary$degree),
  max_degree = max(degree_summary$degree)
)

module_counts <- aggregate(source ~ module, data = edges, FUN = length)
names(module_counts)[names(module_counts) == "source"] <- "n_edges"

print(round(network_summary, 5))
print(module_counts[order(-module_counts$n_edges), ])
print(degree_summary[order(-degree_summary$degree), ])
