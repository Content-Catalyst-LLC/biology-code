# Physiological feedback model in Julia.
#
# This compact workflow simulates coupled homeostatic regulation and calculates
# a physiological condition score.

dt = 0.05
time = collect(0:dt:40)

x_star = 5.0
input_rate = 0.6
a = 0.9
b = 0.5
c = 0.7
d = 0.4
u0 = 0.3
u1 = 0.25

regulated = zeros(Float64, length(time))
hormone = zeros(Float64, length(time))
effector = zeros(Float64, length(time))

regulated[1] = 10.0
hormone[1] = 0.0
effector[1] = 0.0

for i in 2:length(time)
    uptake = u0 + u1 * hormone[i - 1] * regulated[i - 1]

    d_regulated = input_rate - uptake
    d_hormone = a * (regulated[i - 1] - x_star) - b * hormone[i - 1]
    d_effector = c * hormone[i - 1] - d * effector[i - 1]

    regulated[i] = max(0.0, regulated[i - 1] + d_regulated * dt)
    hormone[i] = max(0.0, hormone[i - 1] + d_hormone * dt)
    effector[i] = max(0.0, effector[i - 1] + d_effector * dt)
end

println("Peak X: ", round(maximum(regulated), digits=3))
println("Peak H: ", round(maximum(hormone), digits=3))
println("Peak E: ", round(maximum(effector), digits=3))
println("Final X: ", round(regulated[end], digits=3))
println("Recovery error: ", round(abs(regulated[end] - x_star), digits=3))

feedback_capacity = 0.76
effector_capacity = 0.74
signal_integrity = 0.78
stress_load = 0.25
environmental_pressure = 0.25
recovery_support = 0.72

condition_score =
    0.22 * feedback_capacity +
    0.20 * effector_capacity +
    0.20 * signal_integrity +
    0.18 * recovery_support -
    0.12 * stress_load -
    0.12 * environmental_pressure

println("Physiological condition score: ", round(condition_score, digits=3))
