# Development, differentiation, and organism formation model in Julia.

function exponential_growth(N0, r, t)
    return N0 * exp(r * t)
end

function doubling_time(r)
    return log(2.0) / r
end

function logistic_step(N, r, K, dt)
    dN = r * N * (1.0 - N / K)
    return N + dN * dt
end

function morphogen_concentration(x)
    return exp(-5.0 * x)
end

function assign_fate(c)
    if c > 0.60
        return "fate_A"
    elseif c > 0.25
        return "fate_B"
    else
        return "fate_C"
    end
end

function branch_fraction(k1, k2)
    return k1 / (k1 + k2)
end

N0 = 1.0e4
N24 = 4.0e4
r_est = log(N24 / N0) / 24.0

println("growth_rate=", round(r_est, digits=6))
println("doubling_time_h=", round(doubling_time(r_est), digits=6))
println("logistic_next=", round(logistic_step(1.0e4, 0.07, 6.2e4, 1.0), digits=2))
println("morphogen_at_x_0_2=", round(morphogen_concentration(0.2), digits=4))
println("fate_at_x_0_2=", assign_fate(morphogen_concentration(0.2)))
println("lineage_1_fraction=", round(branch_fraction(0.14, 0.09), digits=4))
