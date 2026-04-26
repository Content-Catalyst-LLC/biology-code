# Distance-decay and community turnover example in Julia.
#
# beta = 1 - exp(-k * distance)
#
# This compact model represents increasing ecological dissimilarity with
# geographic or environmental distance.

using CSV
using DataFrames
using Statistics

data_path = joinpath(@__DIR__, "..", "data", "distance_decay_sites.csv")
distances = CSV.read(data_path, DataFrame)

k = 0.025

distances.predicted_dissimilarity = 1 .- exp.(-k .* distances.distance_km)
distances.residual = distances.observed_dissimilarity .- distances.predicted_dissimilarity

println(distances)
println("Mean observed dissimilarity: ", round(mean(distances.observed_dissimilarity), digits=3))
println("Mean predicted dissimilarity: ", round(mean(distances.predicted_dissimilarity), digits=3))
