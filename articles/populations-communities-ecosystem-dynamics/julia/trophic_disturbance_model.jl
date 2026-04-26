# Coupled trophic dynamics and disturbance model in Julia.
#
# This compact model links producers, herbivores, carnivores, and an ecosystem
# biomass pool under stochastic disturbance.

using Random
using Statistics

Random.seed!(42)

time_steps = 200

producers = zeros(Float64, time_steps)
herbivores = zeros(Float64, time_steps)
carnivores = zeros(Float64, time_steps)
biomass_pool = zeros(Float64, time_steps)

P = 80.0
H = 20.0
C = 5.0
B = 50.0

for t in 1:time_steps
    if rand() < 0.04
        P *= 0.70
        H *= 0.70
        B *= 0.70
    end

    delta_P = 0.08 * P * (1.0 - P / 200.0) - 0.003 * P * H
    delta_H = 0.12 * 0.003 * P * H - 0.03 * H - 0.002 * H * C
    delta_C = 0.10 * 0.002 * H * C - 0.02 * C
    delta_B = 0.20 * P - 0.08 * H - 0.05 * C - 0.04 * B + 0.03 * (H + C)

    P = max(0.0, P + delta_P)
    H = max(0.0, H + delta_H)
    C = max(0.0, C + delta_C)
    B = max(0.0, B + delta_B)

    producers[t] = P
    herbivores[t] = H
    carnivores[t] = C
    biomass_pool[t] = B
end

println("Final producers: ", round(producers[end], digits=3))
println("Final herbivores: ", round(herbivores[end], digits=3))
println("Final carnivores: ", round(carnivores[end], digits=3))
println("Final biomass pool: ", round(biomass_pool[end], digits=3))
println("Mean biomass pool: ", round(mean(biomass_pool), digits=3))
