# Evolution and history of life model in Julia.

function mean_fitness(p; w_AA = 1.12, w_Aa = 1.05, w_aa = 1.0)
    q = 1.0 - p
    return p^2 * w_AA + 2.0 * p * q * w_Aa + q^2 * w_aa
end

function selection_update(p; w_AA = 1.12, w_Aa = 1.05, w_aa = 1.0)
    q = 1.0 - p
    wbar = mean_fitness(p; w_AA = w_AA, w_Aa = w_Aa, w_aa = w_aa)
    return (p^2 * w_AA + p * q * w_Aa) / wbar
end

function jukes_cantor(d)
    if d >= 0.75
        return NaN
    end

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * d)
end

function net_diversification(lambda, mu)
    return lambda - mu
end

p0 = 0.2
p_next = selection_update(p0)

println("p_initial=", p0, " p_next=", round(p_next, digits=6), " mean_fitness=", round(mean_fitness(p0), digits=6))
println("Jukes-Cantor distance=", round(jukes_cantor(0.15), digits=6))
println("Net diversification=", round(net_diversification(0.10, 0.03), digits=6))
