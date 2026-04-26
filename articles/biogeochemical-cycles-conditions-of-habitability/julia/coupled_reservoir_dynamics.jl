# Coupled carbon-nitrogen-oxygen reservoir dynamics in Julia.
#
# This compact model links atmospheric carbon burden, coastal nitrogen surplus,
# and dissolved oxygen stress in a simplified biogeochemical system.

using Random
using Statistics

Random.seed!(42)

years = 60

carbon_burden = zeros(Float64, years + 1)
nitrogen_surplus = zeros(Float64, years + 1)
dissolved_oxygen = zeros(Float64, years + 1)

dissolved_oxygen[1] = 8.0

for year in 1:years
    fossil_emissions = 10.0 * (1.008)^(year - 1)
    land_uptake = max(0.0, 3.0 + randn() * 0.4)
    ocean_uptake = max(0.0, 2.6 + randn() * 0.3)
    disturbance_release = max(0.0, 0.5 + randn() * 0.2)

    reactive_nitrogen = 1.0 * (1.015)^(year - 1)
    coastal_assimilation = clamp(0.65 + randn() * 0.08, 0.0, 1.0)

    carbon_increment = fossil_emissions + disturbance_release - land_uptake - ocean_uptake
    nitrogen_increment = reactive_nitrogen * (1.0 - coastal_assimilation)

    oxygen_production = 1.2
    respiration_demand = 0.7
    decomposition_demand = 0.25 * nitrogen_increment
    stratification_limitation = 0.03 * year / years

    oxygen_change = oxygen_production - respiration_demand - decomposition_demand - stratification_limitation

    carbon_burden[year + 1] = carbon_burden[year] + carbon_increment
    nitrogen_surplus[year + 1] = nitrogen_surplus[year] + nitrogen_increment
    dissolved_oxygen[year + 1] = max(0.0, dissolved_oxygen[year] + oxygen_change)
end

println("Final carbon burden: ", round(carbon_burden[end], digits=3))
println("Final nitrogen surplus: ", round(nitrogen_surplus[end], digits=3))
println("Final dissolved oxygen: ", round(dissolved_oxygen[end], digits=3))
