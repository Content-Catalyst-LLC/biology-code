# Hill-number diversity profile in Julia.
#
# This compact script calculates Hill diversity for several q values.

using CSV
using DataFrames
using Statistics

data_path = joinpath(@__DIR__, "..", "data", "community_matrix.csv")
community_raw = CSV.read(data_path, DataFrame)

sites = community_raw.site
species_matrix = Matrix(select(community_raw, Not(:site)))

function hill_number(counts, q)
    total = sum(counts)

    if total == 0
        return 0.0
    end

    p = counts ./ total
    p = p[p .> 0]

    if q == 1
        return exp(-sum(p .* log.(p)))
    else
        return (sum(p .^ q))^(1 / (1 - q))
    end
end

q_values = [0.0, 1.0, 2.0]

for i in 1:length(sites)
    counts = species_matrix[i, :]
    println("Site: ", sites[i])

    for q in q_values
        println("  q=", q, " Hill diversity=", round(hill_number(counts, q), digits=3))
    end
end
