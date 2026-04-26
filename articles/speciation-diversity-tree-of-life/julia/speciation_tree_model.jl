# Speciation, distance, and diversification model in Julia.

function delta_p(p1, p2)
    return abs(p1 - p2)
end

function fst_style(p1, p2)
    h1 = 2.0 * p1 * (1.0 - p1)
    h2 = 2.0 * p2 * (1.0 - p2)
    pbar = (p1 + p2) / 2.0
    ht = 2.0 * pbar * (1.0 - pbar)
    hs = (h1 + h2) / 2.0

    if ht <= 0
        return 0.0
    end

    return (ht - hs) / ht
end

function jukes_cantor(p_distance)
    if p_distance >= 0.75
        return NaN
    end

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * p_distance)
end

println("Delta p: ", round(delta_p(0.70, 0.42), digits=4))
println("FST-style value: ", round(fst_style(0.70, 0.42), digits=4))
println("Jukes-Cantor distance: ", round(jukes_cantor(0.15), digits=4))

clades = [
    ("net_positive", 0.10, 0.03),
    ("near_equilibrium", 0.07, 0.06),
    ("high_turnover", 0.14, 0.12),
    ("high_extinction", 0.06, 0.11)
]

for clade in clades
    name, lambda, mu = clade
    r = lambda - mu
    println("scenario=", name, " net_diversification=", round(r, digits=4))
end
