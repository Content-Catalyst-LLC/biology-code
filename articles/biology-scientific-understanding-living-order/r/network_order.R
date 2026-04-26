# Biological network order workflow in R.

network_path <- file.path("data", "network_edges.csv")

if (!file.exists(network_path)) {
  network_path <- file.path("..", "data", "network_edges.csv")
}

edges <- read.csv(network_path)

nodes <- sort(unique(c(edges$source, edges$target)))

centrality <- do.call(
  rbind,
  lapply(nodes, function(node) {
    mask <- edges$source == node | edges$target == node

    data.frame(
      node = node,
      degree = sum(mask),
      weighted_degree = sum(edges$interaction_weight[mask]),
      mean_interaction_weight = mean(edges$interaction_weight[mask])
    )
  })
)

centrality <- centrality[order(-centrality$weighted_degree), ]

print(round(centrality, 3))

type_summary <- aggregate(
  interaction_weight ~ interaction_type,
  data = edges,
  FUN = mean
)

names(type_summary)[2] <- "mean_weight"

print(round(type_summary, 3))
