# Biological network summary from an edge list.

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
  }),
  weighted_degree = sapply(nodes, function(node) {
    sum(edges$weight[edges$source == node | edges$target == node])
  })
)

network_summary <- data.frame(
  n_nodes = length(nodes),
  n_edges = nrow(edges),
  density = (2 * nrow(edges)) / (length(nodes) * (length(nodes) - 1)),
  mean_degree = mean(degree_summary$degree),
  max_degree = max(degree_summary$degree)
)

print(round(network_summary, 5))
print(degree_summary[order(-degree_summary$degree), ])
