# Degree centrality workflow.

data_path <- file.path("data", "biological_network_edges.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "biological_network_edges.csv")
}

edges <- read.csv(data_path)
nodes <- sort(unique(c(edges$source, edges$target)))

degree_summary <- data.frame(
  node = nodes,
  degree = sapply(nodes, function(node) {
    sum(edges$source == node | edges$target == node)
  })
)

degree_summary$degree_centrality <- degree_summary$degree / (length(nodes) - 1)

print(degree_summary[order(-degree_summary$degree_centrality), ])
