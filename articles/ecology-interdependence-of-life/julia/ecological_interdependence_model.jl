# Ecological interdependence model in Julia.
#
# This compact workflow simulates producers, herbivores, carnivores, and a
# biomass pool under stochastic disturbance. It also calculates network
# connectance from a small adjacency matrix.

using Random
using Statistics

Random.seed!(42)

time_steps = 150

producers = zeros(Float64, time_steps)
herbivores = zeros(Float64, time_steps)
carnivores = zeros(Float64, time_steps)
biomass_pool = zeros(Float64, time_steps)

P = 100.0
H = 30.0
C = 8.0
B = 60.0

for t in 1:time_steps
    if rand() < 0.04
        P *= 0.75
        H *= 0.75
        B *= 0.75
    end

    delta_P = 0.10 * P * (1.0 - P / 250.0) - 0.0035 * P * H
    delta_H = 0.15 * 0.0035 * P * H - 0.04 * H - 0.0020 * H * C
    delta_C = 0.10 * 0.0020 * H * C - 0.03 * C
    delta_B = 0.18 * P - 0.07 * H - 0.05 * C - 0.05 * B + 0.02 * (H + C)

    P = max(0.0, P + delta_P)
    H = max(0.0, H + delta_H)
    C = max(0.0, C + delta_C)
    B = max(0.0, B + delta_B)

    producers[t] = P
    herbivores[t] = H
    carnivores[t] = C
    biomass_pool[t] = B
end

adjacency = [
    0 1 0 0 1;
    0 0 1 0 1;
    0 0 0 1 0;
    1 0 0 0 0;
    1 1 0 0 0
]

species_count = size(adjacency, 1)
link_count = sum(adjacency)
connectance = link_count / species_count^2

println("Final producers: ", round(producers[end], digits=3))
println("Final herbivores: ", round(herbivores[end], digits=3))
println("Final carnivores: ", round(carnivores[end], digits=3))
println("Final biomass pool: ", round(biomass_pool[end], digits=3))
println("Mean biomass pool: ", round(mean(biomass_pool), digits=3))
println("Network connectance: ", round(connectance, digits=3))
