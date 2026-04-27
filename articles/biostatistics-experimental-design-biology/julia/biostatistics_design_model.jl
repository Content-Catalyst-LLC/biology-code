# Biostatistics and experimental-design kernels in Julia.

function mean_value(values)
    return sum(values) / length(values)
end

function sample_sd(values)
    m = mean_value(values)
    return sqrt(sum((values .- m).^2) / (length(values) - 1))
end

function two_group_summary(control, treated)
    n0 = length(control)
    n1 = length(treated)

    mean0 = mean_value(control)
    mean1 = mean_value(treated)

    sd0 = sample_sd(control)
    sd1 = sample_sd(treated)

    pooled_sd = sqrt(((n0 - 1) * sd0^2 + (n1 - 1) * sd1^2) / (n0 + n1 - 2))
    difference = mean1 - mean0
    effect_size_d = difference / pooled_sd
    se_difference = sqrt(sd0^2 / n0 + sd1^2 / n1)

    return mean0, mean1, difference, pooled_sd, effect_size_d, se_difference
end

function approximate_n(effect_size_d)
    return 2 * (1.96 + 0.84)^2 / effect_size_d^2
end

control = [10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4]
treated = [12.1, 11.7, 12.4, 11.9, 12.0, 12.6, 11.8, 12.3]

mean0, mean1, difference, pooled_sd, effect_size_d, se_difference = two_group_summary(control, treated)

println("control_mean=", round(mean0, digits=5))
println("treated_mean=", round(mean1, digits=5))
println("mean_difference=", round(difference, digits=5))
println("pooled_sd=", round(pooled_sd, digits=5))
println("effect_size_d=", round(effect_size_d, digits=5))
println("se_difference=", round(se_difference, digits=5))
println("approx_n_for_d_0_8=", round(approximate_n(0.8), digits=3))
