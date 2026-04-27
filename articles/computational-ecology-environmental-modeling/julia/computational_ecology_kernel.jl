# Computational ecology kernel in Julia.

function logistic(x)
    return 1.0 / (1.0 + exp(-x))
end

function habitat_suitability(temperature_c, precipitation_mm, habitat_quality, disturbance)
    score = -2.0 + 0.05 * temperature_c + 0.0015 * precipitation_mm + 2.4 * habitat_quality - 2.0 * disturbance
    return logistic(score)
end

function patch_occupancy(initial_occupancy, colonization, extinction, steps)
    occupancy = initial_occupancy
    for _ in 1:steps
        occupancy = occupancy * (1.0 - extinction) + (1.0 - occupancy) * colonization
        occupancy = min(max(occupancy, 0.0), 1.0)
    end
    return occupancy
end

function runoff(precipitation_mm, infiltration_fraction, runoff_coefficient)
    return precipitation_mm * (1.0 - infiltration_fraction) * runoff_coefficient
end

println("suitability=", round(habitat_suitability(16.2, 820.0, 0.82, 0.18), digits=5))
println("final_occupancy=", round(patch_occupancy(0.42, 0.12, 0.08, 30), digits=5))
println("runoff_mm=", round(runoff(42.0, 0.62, 0.30), digits=5))
