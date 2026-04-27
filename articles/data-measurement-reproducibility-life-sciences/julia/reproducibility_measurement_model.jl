# Reproducibility and measurement quality kernels in Julia.

function mean_value(values)
    return sum(values) / length(values)
end

function sample_sd(values)
    m = mean_value(values)
    return sqrt(sum((values .- m).^2) / (length(values) - 1))
end

function coefficient_of_variation(values)
    return sample_sd(values) / mean_value(values)
end

function combined_uncertainty(components)
    return sqrt(sum(components .^ 2))
end

values = [10.2, 10.5, 10.1, 10.4, 10.8, 10.7, 10.6, 10.3, 10.9, 10.4]
components = [0.08, 0.05, 0.11, 0.06]

uc = combined_uncertainty(components)
U = 2.0 * uc

println("mean_value=", round(mean_value(values), digits=5))
println("sample_sd=", round(sample_sd(values), digits=5))
println("coefficient_of_variation=", round(coefficient_of_variation(values), digits=5))
println("combined_standard_uncertainty=", round(uc, digits=5))
println("expanded_uncertainty=", round(U, digits=5))
