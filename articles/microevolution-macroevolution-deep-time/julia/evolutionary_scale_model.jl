# Evolutionary-scale model in Julia.

function hardy_weinberg(p)
    q = 1.0 - p
    return (AA = p^2, Aa = 2.0 * p * q, aa = q^2)
end

function selection_update(p; w_AA = 1.15, w_Aa = 1.08, w_aa = 1.0)
    q = 1.0 - p
    f_AA = p^2
    f_Aa = 2.0 * p * q
    f_aa = q^2

    wbar = f_AA * w_AA + f_Aa * w_Aa + f_aa * w_aa
    p_next = (f_AA * w_AA + 0.5 * f_Aa * w_Aa) / wbar

    return (p_next = p_next, mean_fitness = wbar)
end

hw = hardy_weinberg(0.8)
println("AA=", round(hw.AA, digits=4), " Aa=", round(hw.Aa, digits=4), " aa=", round(hw.aa, digits=4))

sel = selection_update(0.2)
println("p_next=", round(sel.p_next, digits=6), " mean_fitness=", round(sel.mean_fitness, digits=6))

clades = [
    ("Clade_A", 18.0, 7.0, 20.0),
    ("Clade_B", 9.0, 8.0, 20.0),
    ("Clade_C", 25.0, 10.0, 20.0),
    ("Clade_D", 12.0, 14.0, 20.0)
]

for clade in clades
    name, originations, extinctions, interval_myr = clade
    lambda = originations / interval_myr
    mu = extinctions / interval_myr
    net = lambda - mu

    println(
        "clade=", name,
        " lambda=", round(lambda, digits=4),
        " mu=", round(mu, digits=4),
        " net_diversification=", round(net, digits=4)
    )
end
