# Population genetics model in Julia.

function hardy_weinberg(p)
    q = 1.0 - p
    return (p = p, q = q, AA = p^2, Aa = 2.0 * p * q, aa = q^2, He = 2.0 * p * q)
end

function selection_update(p; W_AA = 1.15, W_Aa = 1.08, W_aa = 1.0)
    q = 1.0 - p
    f_AA = p^2
    f_Aa = 2.0 * p * q
    f_aa = q^2

    Wbar = f_AA * W_AA + f_Aa * W_Aa + f_aa * W_aa
    p_next = (f_AA * W_AA + 0.5 * f_Aa * W_Aa) / Wbar

    return (p_next = p_next, delta_p = p_next - p, Wbar = Wbar)
end

function mutation_update(p; mu = 0.0015, nu = 0.0001)
    q = 1.0 - p
    return p * (1.0 - mu) + q * nu
end

function migration_update(p; m = 0.04, p_migrant = 0.15)
    return (1.0 - m) * p + m * p_migrant
end

function fst_style(values)
    pbar = sum(values) / length(values)
    HS = sum(2.0 .* values .* (1.0 .- values)) / length(values)
    HT = 2.0 * pbar * (1.0 - pbar)

    if HT <= 0.0
        return 0.0
    end

    return (HT - HS) / HT
end

hw = hardy_weinberg(0.7)
println("AA=", round(hw.AA, digits=4), " Aa=", round(hw.Aa, digits=4), " aa=", round(hw.aa, digits=4), " He=", round(hw.He, digits=4))

sel = selection_update(0.2)
println("selection p_next=", round(sel.p_next, digits=6), " Wbar=", round(sel.Wbar, digits=6))

println("mutation update=", round(mutation_update(0.99), digits=6))
println("migration update=", round(migration_update(0.9), digits=6))
println("FST-style=", round(fst_style([0.42, 0.45, 0.20, 0.48]), digits=6))
