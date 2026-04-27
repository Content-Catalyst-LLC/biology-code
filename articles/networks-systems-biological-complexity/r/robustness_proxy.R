# Simple robustness proxy by node removal.

data_path <- file.path("data", "biological_network_edges.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "biological_network_edges.csv")
}

edges <- read.csv(data_path)
nodes <- sort(unique(c(edges$source, edges$target)))

remove_node_summary <- function(node_to_remove) {
  remaining_edges <- edges[
    edges$source != node_to_remove & edges$target != node_to_remove,
  ]

  data.frame(
    removed_node = node_to_remove,
    original_edges = nrow(edges),
    remaining_edges = nrow(remaining_edges),
    edge_retention = nrow(remaining_edges) / nrow(edges),
    edge_loss = 1 - nrow(remaining_edges) / nrow(edges)
  )
}

robustness_df <- do.call(rbind, lapply(nodes, remove_node_summary))

print(robustness_df[order(robustness_df$edge_retention), ])
