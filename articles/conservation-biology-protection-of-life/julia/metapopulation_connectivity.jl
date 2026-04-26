# Metapopulation connectivity example in Julia.
#
# This compact simulation tracks patch occupancy under colonization and
# extinction probabilities influenced by habitat quality and distance.

using Random
using Statistics

Random.seed!(42)

patch_quality = [0.82, 0.55, 0.91, 0.40, 0.68, 0.61]
nearest_neighbor_km = [2.4, 4.8, 3.1, 8.6, 2.9, 5.3]
occupied = [true, false, true, false, true, false]

years = 40
base_colonization = 0.35
base_extinction = 0.12

function simulate_metapopulation(occupied, patch_quality, nearest_neighbor_km, years)
    occupancy_history = zeros(Int, years + 1, length(occupied))
    occupancy_history[1, :] .= Int.(occupied)

    current = copy(occupied)

    for year in 1:years
        source_fraction = mean(current)

        for i in eachindex(current)
            colonization_probability =
                base_colonization * source_fraction * patch_quality[i] * exp(-0.08 * nearest_neighbor_km[i])

            extinction_probability =
                base_extinction * (1.0 - patch_quality[i]) + 0.03 * nearest_neighbor_km[i] / 10.0

            if current[i]
                current[i] = rand() > extinction_probability
            else
                current[i] = rand() < colonization_probability
            end
        end

        occupancy_history[year + 1, :] .= Int.(current)
    end

    return occupancy_history
end

history = simulate_metapopulation(occupied, patch_quality, nearest_neighbor_km, years)

println("Final occupied patches: ", sum(history[end, :]))
println("Mean occupancy through time: ", round(mean(sum(history, dims=2)), digits=3))
