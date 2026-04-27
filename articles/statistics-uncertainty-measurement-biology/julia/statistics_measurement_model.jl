# Statistics, uncertainty, and measurement model in Julia.

function descriptive_uncertainty(values)
    n = length(values)
    mean_value = sum(values) / n
    sd_value = sqrt(sum((values .- mean_value).^2) / (n - 1))
    se_value = sd_value / sqrt(n)
    return n, mean_value, sd_value, se_value, mean_value - 1.96 * se_value, mean_value + 1.96 * se_value
end

function combined_standard_uncertainty(components)
    return sqrt(sum(components .^ 2))
end

function linear_calibration(x, y)
    n = length(x)
    mean_x = sum(x) / n
    mean_y = sum(y) / n
    slope = sum((x .- mean_x) .* (y .- mean_y)) / sum((x .- mean_x).^2)
    intercept = mean_y - slope * mean_x
    fitted = intercept .+ slope .* x
    ss_res = sum((y .- fitted).^2)
    ss_tot = sum((y .- mean_y).^2)
    r2 = 1 - ss_res / ss_tot
    return intercept, slope, r2
end

values = [10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4, 11.3, 10.7]
n, mean_value, sd_value, se_value, ci_lower, ci_upper = descriptive_uncertainty(values)

println("n=", n)
println("mean=", round(mean_value, digits=5))
println("sd=", round(sd_value, digits=5))
println("se=", round(se_value, digits=5))
println("ci_lower=", round(ci_lower, digits=5))
println("ci_upper=", round(ci_upper, digits=5))

components = [0.12, 0.08, 0.15, 0.06, 0.05]
println("combined_uncertainty=", round(combined_standard_uncertainty(components), digits=5))

x = [0, 1, 2, 5, 10, 20]
y = [0.05, 0.82, 1.58, 3.95, 7.84, 15.70]
intercept, slope, r2 = linear_calibration(x, y)
println("calibration_intercept=", round(intercept, digits=5))
println("calibration_slope=", round(slope, digits=5))
println("calibration_r2=", round(r2, digits=5))
