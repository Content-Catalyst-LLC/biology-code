# Stochastic population model and metapopulation occupancy in Julia.
#
# This compact workflow simulates logistic growth with harvest and catastrophe
# risk, then compares a simple patch occupancy model.

using Random
using Statistics

Random.seed!(123)

years = 50
n_sims = 1000

initial_population = 80.0
growth_rate_mean = 0.18
growth_rate_sd = 0.08
carrying_capacity_mean = 500.0
carrying_capacity_sd = 40.0
harvest = 5.0
catastrophe_probability = 0.05
catastrophe_multiplier = 0.60
quasi_extinction_threshold = 20.0

final_sizes = zeros(Float64, n_sims)
minimum_sizes = zeros(Float64, n_sims)

for sim in 1:n_sims
    population_size = initial_population
    min_size = population_size

    for year in 1:years
        growth_rate_t = growth_rate_mean + randn() * growth_rate_sd
        carrying_capacity_t = max(
            quasi_extinction_threshold,
            carrying_capacity_mean + randn() * carrying_capacity_sd
        )

        population_size = population_size +
            growth_rate_t * population_size *
            (1.0 - population_size / carrying_capacity_t) -
            harvest

        if rand() < catastrophe_probability
            population_size *= catastrophe_multiplier
        end

        population_size = max(0.0, population_size)
        min_size = min(min_size, population_size)

        if population_size == 0.0
            break
        end
    end

    final_sizes[sim] = population_size
    minimum_sizes[sim] = min_size
end

extinction_risk = mean(final_sizes .== 0.0)
quasi_extinction_risk = mean(minimum_sizes .<= quasi_extinction_threshold)

println("Extinction risk: ", round(extinction_risk, digits=3))
println("Quasi-extinction risk: ", round(quasi_extinction_risk, digits=3))
println("Mean final population size: ", round(mean(final_sizes), digits=3))
println("Median final population size: ", round(median(final_sizes), digits=3))

# Simple metapopulation occupancy example.
occupancy = 0.35
colonization_rate = 0.28
extinction_rate = 0.08

for year in 1:60
    delta = colonization_rate * occupancy * (1.0 - occupancy) -
        extinction_rate * occupancy

    occupancy = clamp(occupancy + delta, 0.0, 1.0)
end

println("Final metapopulation occupancy: ", round(occupancy, digits=3))
