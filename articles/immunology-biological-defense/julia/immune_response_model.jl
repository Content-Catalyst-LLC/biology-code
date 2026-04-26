# Immune response model in Julia.
#
# This compact workflow simulates coupled pathogen, immune, and damage
# dynamics, then compares a simple immune-condition score.

dt = 0.05
time = collect(0:dt:30)

r = 0.45
c = 0.12
alpha = 0.08
delta = 0.18
gamma = 0.06
rho = 0.10

pathogen = zeros(Float64, length(time))
immune = zeros(Float64, length(time))
damage = zeros(Float64, length(time))

pathogen[1] = 50.0
immune[1] = 2.0
damage[1] = 0.0

for i in 2:length(time)
    d_pathogen = r * pathogen[i - 1] - c * immune[i - 1] * pathogen[i - 1]
    d_immune = alpha * pathogen[i - 1] - delta * immune[i - 1]
    d_damage = gamma * immune[i - 1] - rho * damage[i - 1]

    pathogen[i] = max(0.0, pathogen[i - 1] + d_pathogen * dt)
    immune[i] = max(0.0, immune[i - 1] + d_immune * dt)
    damage[i] = max(0.0, damage[i - 1] + d_damage * dt)
end

println("Peak pathogen: ", round(maximum(pathogen), digits=3))
println("Peak immune: ", round(maximum(immune), digits=3))
println("Peak damage: ", round(maximum(damage), digits=3))
println("Final pathogen: ", round(pathogen[end], digits=3))
println("Final damage: ", round(damage[end], digits=3))

clearance_capacity = 0.75
activation_capacity = 0.70
regulatory_capacity = 0.72
damage_pressure = 0.25
stress_load = 0.25
memory_support = 0.70

immune_condition_score =
    0.22 * clearance_capacity +
    0.18 * activation_capacity +
    0.22 * regulatory_capacity +
    0.18 * memory_support -
    0.15 * damage_pressure -
    0.15 * stress_load

println("Immune condition score: ", round(immune_condition_score, digits=3))
