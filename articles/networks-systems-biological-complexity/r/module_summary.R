# Module-level network summary.

edge_path <- file.path("data", "biological_network_edges.csv")
node_path <- file.path("data", "biological_network_nodes.csv")

if (!file.exists(edge_path)) {
  edge_path <- file.path("..", "data", "biological_network_edges.csv")
  node_path <- file.path("..", "data", "biological_network_nodes.csv")
}

edges <- read.csv(edge_path)
nodes <- read.csv(node_path)

module_lookup <- setNames(nodes$module, nodes$node)

edges$source_module <- module_lookup[edges$source]
edges$target_module <- module_lookup[edges$target]
edges$within_module <- edges$source_module == edges$target_module

overall <- data.frame(
  total_edges = nrow(edges),
  within_module_edges = sum(edges$within_module),
  between_module_edges = sum(!edges$within_module),
  within_module_fraction = mean(edges$within_module)
)

module_summary <- aggregate(
  weight ~ source_module + target_module,
  data = edges,
  FUN = mean
)

edge_counts <- aggregate(
  source ~ source_module + target_module,
  data = edges,
  FUN = length
)

names(edge_counts)[names(edge_counts) == "source"] <- "n_edges"

module_summary <- merge(module_summary, edge_counts)

print(round(overall, 5))
print(module_summary[order(-module_summary$n_edges), ])
