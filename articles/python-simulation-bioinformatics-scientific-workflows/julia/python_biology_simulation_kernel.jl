# Python biology simulation cross-language kernel in Julia.

function logistic_growth(initial_population, growth_rate, carrying_capacity, dt, steps)
    population = Float64(initial_population)
    trajectory = Float64[]

    for step in 0:steps
        push!(trajectory, population)
        growth = growth_rate * population * (1.0 - population / carrying_capacity)
        population = max(population + dt * growth, 0.0)
    end

    return trajectory
end

function gc_content(sequence)
    seq = uppercase(sequence)
    valid = [base for base in seq if base in ['A', 'C', 'G', 'T']]
    if length(valid) == 0
        return NaN
    end
    return count(base -> base == 'G' || base == 'C', valid) / length(valid)
end

trajectory = logistic_growth(25.0, 0.35, 1000.0, 0.1, 200)
println("final_population=", round(trajectory[end], digits=5))
println("gc_content=", round(gc_content("ATGCGCGTAATTAACCGGTTACCGTAGCTA"), digits=5))
