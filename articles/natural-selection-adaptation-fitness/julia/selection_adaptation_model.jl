# Natural selection and adaptation model in Julia.

function mean_fitness(p; w_AA = 1.15, w_Aa = 1.08, w_aa = 1.0)
    q = 1.0 - p
    return p^2 * w_AA + 2.0 * p * q * w_Aa + q^2 * w_aa
end

function selection_update(p; w_AA = 1.15, w_Aa = 1.08, w_aa = 1.0)
    q = 1.0 - p
    wbar = mean_fitness(p; w_AA = w_AA, w_Aa = w_Aa, w_aa = w_aa)
    return (p^2 * w_AA + p * q * w_Aa) / wbar
end

function breeder_response(h2, S)
    return h2 * S
end

p0 = 0.2
p_next = selection_update(p0)
println("p_initial=", p0, " p_next=", round(p_next, digits=6), " delta_p=", round(p_next - p0, digits=6))
println("mean_fitness=", round(mean_fitness(p0), digits=6))

S = 0.62
h2 = 0.40
R = breeder_response(h2, S)
println("selection_differential=", S, " heritability=", h2, " response=", round(R, digits=6))
