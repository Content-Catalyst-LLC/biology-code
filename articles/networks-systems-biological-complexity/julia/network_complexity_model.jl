# Network and biological complexity kernels in Julia.

function degree_from_adjacency(A)
    n = size(A, 1)
    degrees = zeros(Float64, n)

    for i in 1:n
        degrees[i] = sum(A[i, :] .> 0)
    end

    return degrees
end

function density_from_adjacency(A)
    n = size(A, 1)
    edges = sum(A .> 0) / 2
    possible = n * (n - 1) / 2
    return edges / possible
end

function diffuse(A, state, alpha, decay, steps)
    x = copy(state)

    for _ in 1:steps
        x = x + alpha * A * x - decay * x
        x = max.(x, 0.0)
    end

    return x
end

A = [
    0.0 1.0 0.8 0.0 0.0 0.0;
    1.0 0.0 0.7 1.2 0.0 0.0;
    0.8 0.7 0.0 0.0 0.9 0.0;
    0.0 1.2 0.0 0.0 1.1 0.6;
    0.0 0.0 0.9 1.1 0.0 0.5;
    0.0 0.0 0.0 0.6 0.5 0.0
]

degrees = degree_from_adjacency(A)
state = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0]
final_state = diffuse(A, state, 0.08, 0.04, 20)

println("density=", round(density_from_adjacency(A), digits=5))
println("mean_degree=", round(sum(degrees) / length(degrees), digits=5))
println("max_degree=", maximum(degrees))
println("final_state=", round.(final_state, digits=5))
