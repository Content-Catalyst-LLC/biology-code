# Biodiversity workflow in R.
#
# This script calculates richness, Shannon, Simpson, Hill numbers, beta
# diversity, NMDS ordination, and functional diversity from compact
# site-by-species and trait datasets.

# Install packages if needed:
# install.packages(c("vegan", "FD"))

library(vegan)
library(FD)

community_path <- file.path("data", "community_matrix.csv")
traits_path <- file.path("data", "species_traits.csv")

if (!file.exists(community_path)) {
  community_path <- file.path("..", "data", "community_matrix.csv")
  traits_path <- file.path("..", "data", "species_traits.csv")
}

comm_raw <- read.csv(community_path)
rownames(comm_raw) <- comm_raw$site
comm <- comm_raw[, setdiff(names(comm_raw), "site")]

traits_raw <- read.csv(traits_path)
rownames(traits_raw) <- traits_raw$species
traits <- traits_raw[, c("body_size", "trophic_level", "dispersal")]

richness <- specnumber(comm)
shannon <- diversity(comm, index = "shannon")
simpson <- diversity(comm, index = "simpson")
invsimpson <- diversity(comm, index = "invsimpson")

hill_q0 <- richness
hill_q1 <- exp(shannon)
hill_q2 <- invsimpson

div_summary <- data.frame(
  site = rownames(comm),
  richness = richness,
  shannon = round(shannon, 3),
  simpson = round(simpson, 3),
  hill_q0 = round(hill_q0, 3),
  hill_q1 = round(hill_q1, 3),
  hill_q2 = round(hill_q2, 3)
)

print(div_summary)

bray <- vegdist(comm, method = "bray")
print(as.matrix(bray))

ord <- metaMDS(comm, distance = "bray", k = 2, trymax = 50, trace = FALSE)
print(ord$points)

fd_res <- dbFD(
  x = traits,
  a = comm,
  calc.FRic = TRUE,
  calc.FDiv = TRUE,
  calc.CWM = FALSE
)

fd_summary <- data.frame(
  site = rownames(comm),
  FRic = round(fd_res$FRic, 3),
  FEve = round(fd_res$FEve, 3),
  FDiv = round(fd_res$FDiv, 3),
  FDis = round(fd_res$FDis, 3)
)

print(fd_summary)
