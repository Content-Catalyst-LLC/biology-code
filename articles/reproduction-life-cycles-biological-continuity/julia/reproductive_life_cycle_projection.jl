# Reproductive life-cycle projection in Julia.
#
# This script projects a stage-structured life cycle and calculates a
# continuity score for synthetic life-history units.

using LinearAlgebra
using Statistics

A = [
    0.0  0.0  1.8;
    0.45 0.0  0.0;
    0.0  0.70 0.82
]

stages = ["juvenile", "subadult", "adult"]
n = [50.0, 20.0, 15.0]
time_steps = 20

trajectory = zeros(Float64, time_steps + 1, length(n))
trajectory[1, :] = n

for t in 1:time_steps
    trajectory[t + 1, :] = A * trajectory[t, :]
end

eigen_result = eigen(A)
dominant_index = argmax(real(eigen_result.values))
lambda = real(eigen_result.values[dominant_index])

stable_stage = real(eigen_result.vectors[:, dominant_index])
stable_stage = stable_stage ./ sum(stable_stage)

A_perturbed = copy(A)
A_perturbed[3, 3] *= 0.90
lambda_perturbed = maximum(real(eigen(A_perturbed).values))

println("Final juvenile: ", round(trajectory[end, 1], digits=3))
println("Final subadult: ", round(trajectory[end, 2], digits=3))
println("Final adult: ", round(trajectory[end, 3], digits=3))
println("Final total: ", round(sum(trajectory[end, :]), digits=3))
println("Dominant lambda: ", round(lambda, digits=4))
println("Stable stage distribution: ", round.(stable_stage, digits=4))
println("Perturbed lambda: ", round(lambda_perturbed, digits=4))
println("Change in lambda: ", round(lambda_perturbed - lambda, digits=4))
