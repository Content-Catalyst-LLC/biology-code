# Neural response model in Julia.
#
# This compact workflow simulates a leaky integrator and a small recurrent
# neural network with nonlinear activation.

using Statistics

dt = 0.1
time = collect(0:dt:40)

tau = 3.0
v_rest = -65.0
resistance_scale = 1.0
threshold = -60.0

inputs = zeros(Float64, length(time))

for i in eachindex(time)
    if time[i] >= 5 && time[i] < 8
        inputs[i] = 8.0
    elseif time[i] >= 15 && time[i] < 17
        inputs[i] = 5.0
    elseif time[i] >= 28 && time[i] < 31
        inputs[i] = 10.0
    end
end

voltage = zeros(Float64, length(time))
voltage[1] = v_rest

for i in 2:length(time)
    d_voltage = (-(voltage[i - 1] - v_rest) + resistance_scale * inputs[i - 1]) / tau
    voltage[i] = voltage[i - 1] + d_voltage * dt
end

events = voltage .>= threshold

println("Max voltage: ", round(maximum(voltage), digits=3))
println("Event count: ", sum(events))
println("Final voltage: ", round(voltage[end], digits=3))

weights = [
    0.0  0.8 -0.4;
    0.6  0.0  0.5;
   -0.3  0.7  0.0
]

function sigmoid(x)
    return 1.0 ./ (1.0 .+ exp.(-x))
end

time_steps = 30
activity = zeros(Float64, time_steps, 3)
network_inputs = zeros(Float64, time_steps, 3)

network_inputs[6:12, 1] .= 1.5
network_inputs[11:18, 2] .= 1.0
network_inputs[21:26, 3] .= 1.8

for t in 2:time_steps
    recurrent_drive = weights * activity[t - 1, :]
    activity[t, :] = 0.85 .* activity[t - 1, :] .+ sigmoid(recurrent_drive .+ network_inputs[t - 1, :])
end

println("Final network activity: ", round.(activity[end, :], digits=3))
println("Network mean activity: ", round.(mean(activity, dims=1), digits=3))
