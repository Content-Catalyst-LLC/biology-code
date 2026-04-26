# Coupled productivity-disturbance model in Julia.
#
# This compact model tracks biosphere functional biomass as a stock influenced
# by productivity, respiration, disturbance, land-use loss, and regrowth.

using Random
using Statistics

Random.seed!(123)

years = 60
biomass = zeros(Float64, years + 1)
biomass[1] = 100.0

npp_base = 8.0
respiration_rate = 0.035
disturbance_base = 1.2
land_use_loss = 0.8
regrowth_rate = 0.025

for year in 1:years
    climate_variability = randn() * 0.5
    npp = max(0.0, npp_base + climate_variability)
    respiration = respiration_rate * biomass[year]
    disturbance = max(0.0, disturbance_base + randn() * 0.3)
    regrowth = regrowth_rate * max(0.0, 140.0 - biomass[year])

    dB = npp - respiration - disturbance - land_use_loss + regrowth
    biomass[year + 1] = max(0.0, biomass[year] + dB)
end

println("Final functional biomass stock: ", round(biomass[end], digits=3))
println("Mean functional biomass stock: ", round(mean(biomass), digits=3))
